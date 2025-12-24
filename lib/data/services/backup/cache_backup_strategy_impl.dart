import 'dart:io';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:life_calendar/core/constants/constants.dart';
import 'package:life_calendar/core/extensions/string/file_string_extension.dart';
import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/data/services/backup/backup_strategy.dart';
import 'package:life_calendar/data/services/database_service.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class CacheBackupStrategy implements BackupStrategy {
  const CacheBackupStrategy({required DatabaseService databaseService})
    : _databaseService = databaseService;

  final DatabaseService _databaseService;

  @override
  String get id => 'cache';

  @override
  Future<void> backup(Directory destinationDir) async {
    final tempDir = await getTemporaryDirectory();
    final cacheArchiveFile = File(
      p.join(destinationDir.path, 'cache_archive.zip'),
    );

    // Мы используем ZipFile внутри стратегии, так как кэш сам по себе
    // является zip-архивом внутри основного бэкапа.
    await ZipFile.createFromDirectory(
      sourceDir: tempDir,
      zipFile: cacheArchiveFile,
      recurseSubDirs: true,
      onZipping: (filePath, isDirectory, progress) {
        if (filePath.contains('archive_source')) {
          return ZipFileOperation.skipItem;
        }
        if (isDirectory && filePath.contains('WebView')) {
          return ZipFileOperation.skipItem;
        }
        return ZipFileOperation.includeItem;
      },
    );
  }

  @override
  Future<void> restore(Directory sourceDir) async {
    final cacheZip = File(p.join(sourceDir.path, 'cache_archive.zip'));
    final legacyCacheZip = File(p.join(sourceDir.path, 'cache_archive'));

    File? zipToExtract;
    if (cacheZip.existsSync()) {
      zipToExtract = cacheZip;
    } else if (legacyCacheZip.existsSync()) {
      zipToExtract = legacyCacheZip;
    }

    if (zipToExtract != null) {
      final appDocDir = await getApplicationDocumentsDirectory();
      final tempCacheDir = Directory(p.join(appDocDir.path, 'temp_cache_dir'));

      try {
        await ZipFile.extractToDirectory(
          zipFile: zipToExtract,
          destinationDir: tempCacheDir,
        );

        final imagesDir = Directory(p.join(appDocDir.path, kImageDirName));

        if (!imagesDir.existsSync()) {
          await imagesDir.create(recursive: true);
        }

        for (final fileEntity in tempCacheDir.listSync()) {
          if (fileEntity is Directory &&
              !fileEntity.path.endsWith(kImageDirName)) {
            for (final subFileEntity in fileEntity.listSync()) {
              if (subFileEntity is File && subFileEntity.path.isImage) {
                subFileEntity.copySync(
                  p.join(imagesDir.path, p.basename(subFileEntity.path)),
                );
              }

              subFileEntity.deleteSync(recursive: true);
            }
          }
        }

        tempCacheDir.deleteSync(recursive: true);

        // Исправление путей в БД
        await _databaseService.normalizePhotoPaths();
      } catch (e) {
        logger.w('Failed to restore cache', error: e);
      }
    }
  }
}
