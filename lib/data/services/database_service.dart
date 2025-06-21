import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/models/week/event/event.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/domain/models/week/week_tense/week_tense.dart';
import 'package:life_calendar2/utils/result.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const tableName = 'TheCalendarDatabase';
  late final Database _db;
  final int _dbVersion = 2;

  Future<Result> init() async {
    try {
      _db = await openDatabase(
        '${await getDatabasesPath()}${Platform.pathSeparator}$tableName',
        version: _dbVersion,
        onCreate: (db, version) async {
          final batch = db.batch();
          _createTableV2(batch);
          await batch.commit();
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          final batch = db.batch();
          if (oldVersion == 1) {
            _updateTableV1toV2(batch);
          }
          await batch.commit();
        },
      );

      return const Result.ok(null);
    } on Exception catch (e, s) {
      logger.e('Failed to open database', error: e, stackTrace: s);
      return Result.error(e);
    }
  }

  void _createTableV2(Batch batch) {
    batch
      ..execute('DROP TABLE IF EXISTS $tableName')
      ..execute(
        'CREATE TABLE IF NOT EXISTS $tableName ('
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
  }

  void _updateTableV1toV2(Batch batch) {
    batch.execute('ALTER TABLE $tableName ADD photos TEXT');
  }

  Future<bool> insertAllWeeks(List<Week> weeks) {
    return _db.transaction((txn) async {
      final batch = txn.batch();

      for (final week in weeks) {
        batch.insert(
          tableName,
          week.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      final result = await batch.commit(
        continueOnError: false,
        noResult: false,
      );

      if (result.isNotEmpty) {
        logger.d('Inserted ${result.length} rows in table');
        return true;
      }

      logger.e('Some error: inserted 0 rows');
      return false;
    });
  }

  Future<bool> insertWeek(Week week) async {
    final insertCount = await _db.insert(
      tableName,
      week.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return insertCount == 1;
  }

  Future<List<Week>> getAllWeeks() async {
    final records = await _db.query(tableName);

    final weeks = await compute(_parseWeeks, records);

    return weeks;
  }

  static List<Week> _parseWeeks(List<Map<String, Object?>> records) {
    final weeks = List.generate(
      records.length,
      (i) => Week.fromJson(records[i]),
      growable: false,
    );

    return weeks;
  }

  Future<Week> getWeek(int id) async {
    final records = await _db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return Week.fromJson(records.first);
  }

  Future<Week> getCurrentWeek() async {
    final records = await _db.query(
      tableName,
      where: 'state = ?',
      whereArgs: [WeekTense.current.name],
    );

    if (records.length != 1) {
      logger.w('Number of current week in DB: ${records.length}');
    }

    return Week.fromJson(records.first);
  }

  Future<void> updateAssessment({
    required int weekId,
    required WeekAssessment assessment,
  }) {
    return _db.rawUpdate('UPDATE $tableName SET assessment = ? WHERE id = ?', [
      assessment.name,
      weekId,
    ]);
  }

  Future<void> updateEvents({
    required int weekId,
    required List<Event> events,
  }) {
    return _db.rawUpdate('UPDATE $tableName SET events = ? WHERE id = ?', [
      jsonEncode(events),
      weekId,
    ]);
  }

  Future<void> updateGoals({required int weekId, required List<Goal> goals}) {
    return _db.rawUpdate('UPDATE $tableName SET goals = ? WHERE id = ?', [
      jsonEncode(goals),
      weekId,
    ]);
  }

  Future<void> updateResume({required int weekId, required String resume}) {
    return _db.rawUpdate('UPDATE $tableName SET resume = ? WHERE id = ?', [
      resume,
      weekId,
    ]);
  }

  Future<void> updatePhotos({
    required int weekId,
    required List<String> photos,
  }) {
    return _db.rawUpdate('UPDATE $tableName SET photos = ? WHERE id = ?', [
      jsonEncode(photos),
      weekId,
    ]);
  }
}
