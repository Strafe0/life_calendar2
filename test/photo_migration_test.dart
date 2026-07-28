import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:life_calendar/data/services/database_service.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Tests the v3→v4 photo migration core
/// ([DatabaseService.migratePhotosToImagesDir]): pre-3.0 builds stored raw
/// `image_picker` cache paths and never copied the files, so on upgrade we copy
/// each file into the app images dir and rewrite the DB to bare file names.
void main() {
  late Database db;
  late Directory tempRoot;
  late Directory sourceDir; // stands in for the old image_picker cache
  late Directory imagesDir; // stands in for appDocDir/app_images

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    tempRoot = await Directory.systemTemp.createTemp('photo_migration_test');
    sourceDir = Directory(p.join(tempRoot.path, 'cache'))
      ..createSync(recursive: true);
    imagesDir = Directory(p.join(tempRoot.path, 'app_images'));

    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    // v3 schema (mirrors DatabaseService._createTableV2 + the photos column).
    await db.execute(
      'CREATE TABLE ${DatabaseService.tableName} ('
      'id INTEGER PRIMARY KEY,'
      'yearId INTEGER NOT NULL,'
      'state TEXT NOT NULL,'
      'start INTEGER NOT NULL,'
      'end INTEGER NOT NULL,'
      'assessment TEXT,'
      'goals TEXT,'
      'events TEXT,'
      'resume TEXT,'
      'photos TEXT)',
    );
  });

  tearDown(() async {
    await db.close();
    if (tempRoot.existsSync()) {
      tempRoot.deleteSync(recursive: true);
    }
  });

  Future<void> insertWeek(int id, List<String> photos) {
    return db.insert(DatabaseService.tableName, {
      'id': id,
      'yearId': id,
      'state': 'past',
      'start': 0,
      'end': 1,
      'photos': jsonEncode(photos),
    });
  }

  File createSourceFile(String name, String contents) {
    final file = File(p.join(sourceDir.path, name))
      ..writeAsStringSync(contents);
    return file;
  }

  Future<List<String>> readPhotos(int id) async {
    final rows = await db.query(
      DatabaseService.tableName,
      columns: ['photos'],
      where: 'id = ?',
      whereArgs: [id],
    );
    final raw = rows.single['photos']! as String;
    return (jsonDecode(raw) as List).cast<String>();
  }

  test('copies existing files into images dir and rewrites paths to '
      'basenames', () async {
    final a = createSourceFile('a.jpg', 'aaa');
    final b = createSourceFile('b.png', 'bbb');
    await insertWeek(1, [a.path, b.path]);

    await DatabaseService().migratePhotosToImagesDir(db, imagesDir);

    // DB now holds bare file names.
    expect(await readPhotos(1), ['a.jpg', 'b.png']);

    // Files were copied into the images dir with identical contents.
    final copiedA = File(p.join(imagesDir.path, 'a.jpg'));
    final copiedB = File(p.join(imagesDir.path, 'b.png'));
    expect(copiedA.existsSync(), isTrue);
    expect(copiedB.existsSync(), isTrue);
    expect(copiedA.readAsStringSync(), 'aaa');
    expect(copiedB.readAsStringSync(), 'bbb');

    // Originals are left in place (copy, not move).
    expect(a.existsSync(), isTrue);
  });

  test('keeps a basename record when the source file is gone', () async {
    final missingPath = p.join(sourceDir.path, 'evicted.jpg');
    await insertWeek(1, [missingPath]);

    await DatabaseService().migratePhotosToImagesDir(db, imagesDir);

    // The record survives as a bare name, but nothing is fabricated on disk.
    expect(await readPhotos(1), ['evicted.jpg']);
    expect(File(p.join(imagesDir.path, 'evicted.jpg')).existsSync(), isFalse);
  });

  test('is idempotent across repeated runs', () async {
    final a = createSourceFile('a.jpg', 'aaa');
    await insertWeek(1, [a.path]);

    await DatabaseService().migratePhotosToImagesDir(db, imagesDir);
    // Delete the original so a second run cannot re-copy; the already-migrated
    // file in the images dir must be preserved.
    a.deleteSync();
    await DatabaseService().migratePhotosToImagesDir(db, imagesDir);

    expect(await readPhotos(1), ['a.jpg']);
    final copied = File(p.join(imagesDir.path, 'a.jpg'));
    expect(copied.existsSync(), isTrue);
    expect(copied.readAsStringSync(), 'aaa');
  });

  test('leaves rows without photos untouched', () async {
    await insertWeek(1, const []); // stored as '[]'
    await db.insert(DatabaseService.tableName, {
      'id': 2,
      'yearId': 2,
      'state': 'past',
      'start': 0,
      'end': 1,
      'photos': null,
    });

    await DatabaseService().migratePhotosToImagesDir(db, imagesDir);

    expect(await readPhotos(1), isEmpty);
    final row2 = await db.query(
      DatabaseService.tableName,
      columns: ['photos'],
      where: 'id = ?',
      whereArgs: [2],
    );
    expect(row2.single['photos'], isNull);
  });
}
