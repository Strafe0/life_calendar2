import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:life_calendar2/core/constants/constants.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/services/local_backup_service.dart';
import 'package:life_calendar2/utils/result.dart';
import 'package:path_provider/path_provider.dart';

class LocalBackupServiceImpl implements LocalBackupService {
  const LocalBackupServiceImpl();

  @override
  Future<bool> exportCalendar() async {
    try {
      final zipFile = await _createZipFile();

      if (zipFile == null) return false;

      final sourceDir = await _createSourceDir();

      if (sourceDir == null) return false;

      await ZipFile.createFromDirectory(
        sourceDir: sourceDir,
        zipFile: zipFile,
        recurseSubDirs: true,
      );

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
    }
  }

  @override
  Future<Result<bool>> importCalendar() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip'],
      );

      if (result == null) {
        logger.w('File was not picked');
        return const Result.ok(false);
      }

      final file = File(result.files.single.path!);

      final tempDir = await getTemporaryDirectory();
      final appDir = tempDir.parent;

      // creating a directory in which the archive will be extracted
      final archiveExtractDir = Directory('${appDir.path}/archive_source');
      if (archiveExtractDir.existsSync()) {
        archiveExtractDir.deleteSync(recursive: true);
      }
      archiveExtractDir.createSync();

      await ZipFile.extractToDirectory(
        zipFile: file,
        destinationDir: archiveExtractDir,
      );

      // replacing db
      File(
        '${appDir.path}/databases/TheCalendarDatabase',
      ).deleteSync(recursive: true);
      File(
        '${archiveExtractDir.path}/TheCalendarDatabase',
      ).copySync('${appDir.path}/databases/TheCalendarDatabase');

      // replacing shared_preferences
      File(
        '${appDir.path}/shared_prefs/FlutterSharedPreferences.xml',
      ).deleteSync(recursive: true);
      File(
        '${archiveExtractDir.path}/FlutterSharedPreferences.xml',
      ).copySync('${appDir.path}/shared_prefs/FlutterSharedPreferences.xml');

      // deleting old images
      tempDir.listSync().forEach(
        (element) => element.deleteSync(recursive: true),
      );

      // extracting new images
      final imageArchive = File('${archiveExtractDir.path}/cache_archive');
      await ZipFile.extractToDirectory(
        zipFile: imageArchive,
        destinationDir: tempDir,
      );

      return const Result.ok(true);
    } catch (error, stackTrace) {
      logger.e(
        'Failed to import calendar',
        error: error,
        stackTrace: stackTrace,
      );
      return Result.error(error);
    }
  }

  Future<File?> _createZipFile() async {
    final externalStorageDir = await getExternalStorageDirectory();
    if (externalStorageDir != null && externalStorageDir.existsSync()) {
      final file = File('${externalStorageDir.path}/life-calendar.zip');
      return file;
    } else {
      logger.e('Failed to create zip file in external storage directory');
      return null;
    }
  }

  Future<Directory?> _createSourceDir() async {
    final tempDir = await getTemporaryDirectory();
    final appDir = tempDir.parent;

    // creating the directory that will be archived
    final result = Directory('${appDir.path}/archive_source');
    if (result.existsSync()) {
      result.deleteSync(recursive: true);
    }
    result.createSync();

    // copying db to the directory
    final dbFile = File('${appDir.path}/databases/TheCalendarDatabase');
    if (dbFile.existsSync()) {
      dbFile.copySync('${result.path}/TheCalendarDatabase');
    } else {
      logger.e('Creating archive', error: 'DB file does not exist');
      return null;
    }

    // copying shared_prefs to the directory
    final sharedPrefsFile = File(
      '${appDir.path}/shared_prefs/FlutterSharedPreferences.xml',
    );
    if (sharedPrefsFile.existsSync()) {
      sharedPrefsFile.copySync('${result.path}/FlutterSharedPreferences.xml');
    } else {
      logger.e('Creating archive', error: 'SharedPrefs file does not exist');
      return null;
    }

    // copying images to the directory as archive
    final cacheArchive = File('${result.path}/cache_archive');
    await ZipFile.createFromDirectory(
      sourceDir: tempDir,
      zipFile: cacheArchive,
      recurseSubDirs: true,
      onZipping: (filePath, isDirectory, progress) {
        if (isDirectory && filePath.contains('WebView')) {
          return ZipFileOperation.skipItem;
        } else {
          return ZipFileOperation.includeItem;
        }
      },
    );

    return result;
  }
}
