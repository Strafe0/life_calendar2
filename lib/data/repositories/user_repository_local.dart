import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/services/shared_preferences_service.dart';
import 'package:life_calendar2/domain/models/user/user.dart';
import 'package:life_calendar2/domain/repositories/user_repository.dart';
import 'package:life_calendar2/utils/result.dart';

class UserRepositoryLocal implements UserRepository {
  final SharedPreferencesService _sharedPreferencesService;

  const UserRepositoryLocal({
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

      final birthday = await _sharedPreferencesService.getBirthday();
      final lifespan = await _sharedPreferencesService.getLifespan();

      if (birthday == null || lifespan == null) {
        logger.e('Failed to get birthday: $birthday or $lifespan from prefs');
        return Result.error(Exception());
      }

      return Result.ok(
        User(
          id: '',
          birthday: DateTime.fromMillisecondsSinceEpoch(
            Duration(seconds: birthday).inMilliseconds,
          ),
          lifeSpan: lifespan,
        ),
      );
    } on Exception catch (e, s) {
      logger.e('Failed to get user info from prefs', error: e, stackTrace: s);
      return Result.error(e);
    }
  }
}
