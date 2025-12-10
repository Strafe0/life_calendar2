import 'package:image_picker/image_picker.dart';
import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/domain/services/image_picker_service.dart';

class ImagePickerServiceImpl implements ImagePickerService {
  const ImagePickerServiceImpl();

  @override
  Future<({XFile? file, bool hasError})> pickImage() async {
    final picker = ImagePicker();

    try {
      final file = await picker.pickImage(source: ImageSource.gallery);
      return (file: file, hasError: false);
    } catch (e, s) {
      logger.e('Failed to pick images', error: e, stackTrace: s);
      return (file: null, hasError: true);
    }
  }
}
