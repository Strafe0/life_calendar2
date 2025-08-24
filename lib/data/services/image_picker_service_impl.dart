import 'package:image_picker/image_picker.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/services/image_picker_service.dart';

class ImagePickerServiceImpl implements ImagePickerService {
  const ImagePickerServiceImpl();

  @override
  Future<List<XFile>> pickMultipleImages({int limit = 3}) async {
    final picker = ImagePicker();

    try {
      final List<XFile> files = await picker.pickMultiImage(limit: limit);
      return files;
    } catch (e, s) {
      logger.e('Failed to pick images', error: e, stackTrace: s);
      return [];
    }
  }
}
