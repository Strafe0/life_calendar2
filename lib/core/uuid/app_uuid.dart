import 'package:uuid/uuid.dart';

class AppUuid {
  static const _uuid = Uuid();

  static String generateUserId() => _uuid.v1();
}