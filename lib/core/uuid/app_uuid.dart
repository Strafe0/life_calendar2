import 'package:uuid/uuid.dart';

class AppUuid {
  static const _uuid = Uuid();

  static String generateTimeBasedUuid() => _uuid.v1();
}