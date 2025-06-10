import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/repositories/user_repository/user_repository.dart';
import 'package:life_calendar2/data/services/shared_preferences_service.dart';
import 'package:life_calendar2/domain/models/user/user.dart';
import 'package:life_calendar2/utils/result.dart';

class UserRepositoryImpl implements UserRepository {
  final SharedPreferencesService _sharedPreferencesService;

  const UserRepositoryImpl({
    required SharedPreferencesService sharedPreferencesService,
  }) : _sharedPreferencesService = sharedPreferencesService;

  @override
  Future<Result<void>> createUser(User user) async {
    try {
      await _sharedPreferencesService.setBirthday(
        Duration(milliseconds: user.birthday.millisecondsSinceEpoch).inSeconds,
      );
      await _sharedPreferencesService.setLifespan(user.lifeSpan);

      return const Result.ok(null);
    } on Exception catch (e, s) {
      logger.e('Failed to save user info in prefs', error: e, stackTrace: s);
      return Result.error(e);
    }
  }

  @override
  Future<Result<User>> getUser() async {
    try {
      final isFirstLaunch = await _sharedPreferencesService.isFirstLaunch();
      if (isFirstLaunch) {
        return Result.ok(User.empty());
      }

      final userId = await _sharedPreferencesService.getUserId();
      final birthdate = await _sharedPreferencesService.getBirthday();
      final lifeSpan = await _sharedPreferencesService.getLifespan();

      if (userId == null || birthdate == null || lifeSpan == null) {
        logger.e('Failed to get from prefs UserID (null - ${userId == null}), '
        'or birthdate: (null - ${birthdate == null}), '
        'or lifeSpan(null - ${lifeSpan == null})');
        return Result.error(Exception());
      }

      return Result.ok(
        User(
          id: userId,
          birthday: DateTime.fromMillisecondsSinceEpoch(
            Duration(seconds: birthdate).inMilliseconds,
          ),
          lifeSpan: lifeSpan,
        ),
      );
    } on Exception catch (e, s) {
      logger.e('Failed to get user info from prefs', error: e, stackTrace: s);
      return Result.error(e);
    }
  }
}
