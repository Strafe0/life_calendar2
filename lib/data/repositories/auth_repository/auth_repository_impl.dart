import 'package:life_calendar2/core/extensions/date_time/date_time_extension.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/repositories/auth_repository/auth_repository.dart';
import 'package:life_calendar2/data/services/shared_preferences_service.dart';
import 'package:life_calendar2/utils/result.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SharedPreferencesService _sharedPreferencesService;

  const AuthRepositoryImpl({
    required SharedPreferencesService sharedPreferencesService,
  }) : _sharedPreferencesService = sharedPreferencesService;

  @override
  Future<Result<void>> register({
    required DateTime birthdate,
    required int lifeSpan,
  }) async {
    try {
      await _sharedPreferencesService.setBirthday(birthdate.toTimeStamp());
      logger.d('Birthdate $birthdate is saved');

      await _sharedPreferencesService.setLifespan(lifeSpan);
      logger.d('Lifespan $lifeSpan is saved');

      await _sharedPreferencesService.setFirstLaunch(isFirstLaunch: false);
      logger.d('First launch (false) is saved');

      return const Result.ok(null);
    } on Exception catch (e, s) {
      logger.e(
        'Failed to register user ($DateTime, $lifeSpan)',
        error: e,
        stackTrace: s,
      );
      return Result.error(e);
    }
  }
}
