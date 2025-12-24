import 'dart:io' show Directory, File;

import 'package:image_picker/image_picker.dart';
import 'package:life_calendar/core/constants/constants.dart';
import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/domain/services/image_picker_service.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class ImagePickerServiceImpl implements ImagePickerService {
  const ImagePickerServiceImpl();

  @override
  Future<({XFile? file, bool hasError})> pickImage() async {
    final picker = ImagePicker();

    try {
      final file = await picker.pickImage(source: ImageSource.gallery);
      final filePath = file?.path;

      if (filePath == null) {
        return (file: null, hasError: true);
      }

      final appDocDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory(p.join(appDocDir.path, kImageDirName));

      if (!imagesDir.existsSync()) {
        await imagesDir.create(recursive: true);
      }

      final fileExt = p.extension(filePath);
      final newFileName = '${DateTime.now().millisecondsSinceEpoch}$fileExt';

      final destinationPath = p.join(imagesDir.path, newFileName);

      await File(filePath).copy(destinationPath);

      return (file: file, hasError: false);
    } catch (e, s) {
      logger.e('Failed to pick images', error: e, stackTrace: s);
      return (file: null, hasError: true);
    }
  }
}
