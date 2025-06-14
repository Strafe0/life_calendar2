import 'package:life_calendar2/domain/models/user/user.dart';
import 'package:life_calendar2/utils/result.dart';

abstract class AuthRepository {
  Future<Result<User>> register({
    required DateTime birthdate,
    required int lifeSpan,
  });
}
