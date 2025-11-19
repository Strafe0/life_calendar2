import 'package:life_calendar2/domain/models/user/user.dart';
import 'package:life_calendar2/utils/result.dart';

abstract class UserRepository {
  Future<Result<void>> createUser(User user);
  Future<Result<User>> getUser();
  Future<Result<void>> increaseLifeSpan({
    required int oldLifeSpan,
    required int newLifeSpan,
  });
  Future<Result<void>> reduceLifeSpan({
    required int oldLifeSpan,
    required int newLifeSpan,
  });
}
