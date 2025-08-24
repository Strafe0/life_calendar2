import 'package:image_picker/image_picker.dart';

abstract interface class ImagePickerService {
  Future<List<XFile>> pickMultipleImages();
}