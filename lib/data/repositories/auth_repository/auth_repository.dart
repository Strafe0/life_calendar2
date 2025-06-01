import 'package:life_calendar2/utils/result.dart';

abstract class AuthRepository {
  Future<Result<void>> register({
    required DateTime birthdate,
    required int lifeSpan,
  });
}
