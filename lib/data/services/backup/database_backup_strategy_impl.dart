import 'dart:io';
import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/data/services/backup/backup_strategy.dart';
import 'package:life_calendar/data/services/database_service.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DatabaseBackupStrategy implements BackupStrategy {
  const DatabaseBackupStrategy({required DatabaseService databaseService})
    : _databaseService = databaseService;

  final DatabaseService _databaseService;

  @override
  String get id => 'database';

  @override
  Future<void> backup(Directory destinationDir) async {
    final databasesPath = await getDatabasesPath();
    final dbPath = p.join(databasesPath, DatabaseService.tableName);
    final dbFile = File(dbPath);

    if (dbFile.existsSync()) {
      dbFile.copySync(p.join(destinationDir.path, DatabaseService.tableName));

      // Копируем WAL и SHM
      if (File('$dbPath-wal').existsSync()) {
        File('$dbPath-wal').copySync(
          p.join(destinationDir.path, '${DatabaseService.tableName}-wal'),
        );
      }
      if (File('$dbPath-shm').existsSync()) {
        File('$dbPath-shm').copySync(
          p.join(destinationDir.path, '${DatabaseService.tableName}-shm'),
        );
      }
    } else {
      logger.e('DB file does not exist at $dbPath');
    }
  }

  @override
  Future<void> restore(Directory sourceDir) async {
    // Закрываем соединение перед работой
    await _databaseService.close();

    final sysDbPath = await getDatabasesPath();
    final restoredDb = File(p.join(sourceDir.path, DatabaseService.tableName));

    if (restoredDb.existsSync()) {
      final currentDb = File(p.join(sysDbPath, DatabaseService.tableName));
      if (currentDb.existsSync()) {
        currentDb.deleteSync(recursive: true);
      }

      // Чистим старые WAL/SHM
      final wal = File('${currentDb.path}-wal');
      final shm = File('${currentDb.path}-shm');
      if (wal.existsSync()) {
        wal.deleteSync();
      }
      if (shm.existsSync()) {
        shm.deleteSync();
      }

      // Копируем новые
      restoredDb.copySync(p.join(sysDbPath, DatabaseService.tableName));

      final restoredWal = File('${restoredDb.path}-wal');
      final restoredShm = File('${restoredDb.path}-shm');

      if (restoredWal.existsSync()) {
        restoredWal.copySync(
          p.join(sysDbPath, '${DatabaseService.tableName}-wal'),
        );
      }
      if (restoredShm.existsSync()) {
        restoredShm.copySync(
          p.join(sysDbPath, '${DatabaseService.tableName}-shm'),
        );
      }
    }

    // Переоткрываем базу
    await _databaseService.init();
  }
}
