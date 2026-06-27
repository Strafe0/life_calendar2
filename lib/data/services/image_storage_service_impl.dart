import 'dart:io' show Directory;

import 'package:life_calendar/core/constants/constants.dart';
import 'package:life_calendar/domain/services/image_storage_service.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class ImageStorageServiceImpl implements ImageStorageService {
  const ImageStorageServiceImpl();

  @override
  Future<List<String>> resolvePaths(List<String> photos) async {
    if (photos.isEmpty) return const [];

    final appDocDir = await getApplicationDocumentsDirectory();
    final imagesBaseDir = Directory(p.join(appDocDir.path, kImageDirName));

    return photos
        .map((photo) => p.join(imagesBaseDir.path, p.basename(photo)))
        .toList();
  }
}
