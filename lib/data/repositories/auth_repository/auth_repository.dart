import 'package:life_calendar/domain/models/user/user.dart';
import 'package:life_calendar/utils/result.dart';

abstract class AuthRepository {
  Future<Result<User>> register({
    required DateTime birthdate,
    required int lifeSpan,
  });
}
