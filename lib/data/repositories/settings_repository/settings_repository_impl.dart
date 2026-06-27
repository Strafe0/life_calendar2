import 'package:life_calendar/data/repositories/settings_repository/settings_repository.dart';
import 'package:life_calendar/data/services/shared_preferences_service.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferencesService _sharedPreferencesService;

  const SettingsRepositoryImpl({
    required SharedPreferencesService sharedPreferencesService,
  }) : _sharedPreferencesService = sharedPreferencesService;

  @override
  Future<bool> isFirstLaunch() => _sharedPreferencesService.isFirstLaunch();

  @override
  Future<bool> isFirstLaunchV3() => _sharedPreferencesService.isFirstLaunchV3();

  @override
  Future<void> setFirstLaunchV3({required bool isFirstLaunch}) =>
      _sharedPreferencesService.setFirstLaunchV3(isFirstLaunch: isFirstLaunch);

  @override
  Future<int?> getLifespan() => _sharedPreferencesService.getLifespan();
}
