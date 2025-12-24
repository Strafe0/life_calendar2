import 'package:path/path.dart' as p show extension;

const imageExtensions = {
  '.jpg',
  '.jpeg',
  '.png',
  '.gif',
  '.bmp',
  '.webp',
  '.heic',
};

extension FileExtension on String {
  bool get isImage {
    final extension = p.extension(this).toLowerCase();

    return imageExtensions.contains(extension);
  }
}
