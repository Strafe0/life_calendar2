import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:life_calendar/core/constants/constants.dart';
import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/data/services/analytics/analytics_service_interface.dart';
import 'package:life_calendar/data/services/backup/backup_strategy.dart';
import 'package:life_calendar/domain/services/local_backup_service.dart';
import 'package:life_calendar/utils/result.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class LocalBackupServiceImpl implements LocalBackupService {
  const LocalBackupServiceImpl({
    required List<BackupStrategy> strategies,
    required AnalyticsService analytics,
  }) : _strategies = strategies,
       _analytics = analytics;

  final List<BackupStrategy> _strategies;
  final AnalyticsService _analytics;

  @override
  Future<bool> exportCalendar() async {
    File? zipFile;
    Directory? sourceDir;

    try {
      zipFile = await _createZipFile();
      if (zipFile == null) {
        return false;
      }

      // Если вдруг остался хвост от прошлого раза
      if (zipFile.existsSync()) {
        zipFile.deleteSync();
      }

      sourceDir = await _createSourceDir();
      if (sourceDir == null) {
        return false;
      }

      // 1. Запуск стратегий
      // Если здесь упадет ошибка, мы сразу улетим в catch -> finally
      for (final strategy in _strategies) {
        await strategy.backup(sourceDir);
      }

      // 2. Архивация
      await ZipFile.createFromDirectory(
        sourceDir: sourceDir,
        zipFile: zipFile,
        recurseSubDirs: true,
      );

      // 3. Сохранение
      final formattedDate = fileDateFormat.format(DateTime.now());
      final resultPath = await FileSaver.instance.saveAs(
        name: 'life-calendar-$formattedDate',
        file: zipFile,
        fileExtension: 'zip',
        mimeType: MimeType.zip,
      );

      return resultPath != null;
    } catch (e, s) {
      logger.e('Failed to export calendar', error: e, stackTrace: s);
      return false;
    } finally {
      unawaited(_analytics.logBackup(BackupEvent.export));

      // Очистка
      if (sourceDir != null && sourceDir.existsSync()) {
        try {
          sourceDir.deleteSync(recursive: true);
        } catch (e) {
          logger.w('Failed to clean up sourceDir', error: e);
        }
      }
      if (zipFile != null && zipFile.existsSync()) {
        try {
          zipFile.deleteSync();
        } catch (e) {
          logger.w('Failed to clean up zipFile', error: e);
        }
      }
    }
  }

  @override
  Future<Result<bool>> importCalendar() async {
    Directory? restoreTempDir;

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip'],
      );

      if (result == null) {
        logger.w('File was not picked');
        return const Result.ok(false);
      }

      final zipFile = File(result.files.single.path!);
      final docsDir = await getApplicationDocumentsDirectory();

      restoreTempDir = Directory(p.join(docsDir.path, 'restore_temp'));

      // Подготовка чистой папки
      if (restoreTempDir.existsSync()) {
        restoreTempDir.deleteSync(recursive: true);
      }
      restoreTempDir.createSync(recursive: true);

      // 1. Распаковка архива
      await ZipFile.extractToDirectory(
        zipFile: zipFile,
        destinationDir: restoreTempDir,
      );

      // 2. Запуск стратегий восстановления (Fail Fast)
      for (final strategy in _strategies) {
        // Мы НЕ оборачиваем этот вызов в try-catch.
        // Если стратегия падает (throw), исключение летит выше в общий catch,
        // и процесс импорта прерывается целиком.
        logger.d('Starting restore strategy: ${strategy.id}');
        await strategy.restore(restoreTempDir);
      }

      return const Result.ok(true);
    } catch (error, stackTrace) {
      logger.e(
        'Failed to import calendar',
        error: error,
        stackTrace: stackTrace,
      );

      return Result.error(error);
    } finally {
      unawaited(_analytics.logBackup(BackupEvent.import));

      // Очистка
      if (restoreTempDir != null && restoreTempDir.existsSync()) {
        try {
          restoreTempDir.deleteSync(recursive: true);
        } catch (e) {
          logger.w('Failed to clean up restoreTempDir', error: e);
        }
      }
    }
  }

  Future<File?> _createZipFile() async {
    final externalStorageDir = await getApplicationCacheDirectory();
    return File(p.join(externalStorageDir.path, 'life-calendar.zip'));
  }

  Future<Directory?> _createSourceDir() async {
    try {
      final docsDir = await getApplicationDocumentsDirectory();
      final archiveDir = Directory(p.join(docsDir.path, 'archive_source'));

      if (archiveDir.existsSync()) {
        archiveDir.deleteSync(recursive: true);
      }
      archiveDir.createSync(recursive: true);
      return archiveDir;
    } catch (e) {
      logger.e('Critical error creating source dir', error: e);
      return null;
    }
  }
}
