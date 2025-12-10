import 'dart:io';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/data/services/backup/backup_strategy.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class CacheBackupStrategy implements BackupStrategy {
  const CacheBackupStrategy();

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
      final tempDir = await getTemporaryDirectory();

      if (tempDir.existsSync()) {
        try {
          final entities = tempDir.listSync();
          for (final entity in entities) {
            // Защита от удаления основного архива, если он во временной папке
            if (!entity.path.endsWith('.zip')) {
              try {
                entity.deleteSync(recursive: true);
              } catch (_) {}
            }
          }
        } catch (e) {
          logger.w('Error clearing temp dir', error: e);
        }
      }

      await ZipFile.extractToDirectory(
        zipFile: zipToExtract,
        destinationDir: tempDir,
      );
    }
  }
}
