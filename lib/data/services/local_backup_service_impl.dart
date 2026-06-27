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

      // In case a leftover remains from a previous run
      if (zipFile.existsSync()) {
        zipFile.deleteSync();
      }

      sourceDir = await _createSourceDir();
      if (sourceDir == null) {
        return false;
      }

      // 1. Run the strategies
      // If an error is thrown here, we go straight to catch -> finally
      for (final strategy in _strategies) {
        await strategy.backup(sourceDir);
      }

      // 2. Archiving
      await ZipFile.createFromDirectory(
        sourceDir: sourceDir,
        zipFile: zipFile,
        recurseSubDirs: true,
      );

      // 3. Saving
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

      // Cleanup
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
      final result = await FilePicker.pickFiles(
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

      // Prepare a clean folder
      if (restoreTempDir.existsSync()) {
        restoreTempDir.deleteSync(recursive: true);
      }
      restoreTempDir.createSync(recursive: true);

      // 1. Extract the archive
      await ZipFile.extractToDirectory(
        zipFile: zipFile,
        destinationDir: restoreTempDir,
      );

      // 2. Run the restore strategies (Fail Fast)
      for (final strategy in _strategies) {
        // We do NOT wrap this call in try-catch.
        // If a strategy throws, the exception propagates to the outer catch
        // and the whole import is aborted.
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

      // Cleanup
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
