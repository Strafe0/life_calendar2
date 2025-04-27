import 'package:life_calendar2/core/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  const SharedPreferencesService();

  static const _firstLaunchKey = 'firstTime';
  static const _birthdayKey = 'birthday';
  static const _lifespanKey = 'lifespan';

  Future<bool> isFirstLaunch() async {
    final prefs = SharedPreferencesAsync();

    final isFirstLaunch = await prefs.getBool(_firstLaunchKey);

    if (isFirstLaunch == null) {
      logger.d('isFirstLaunch from prefs is null');
      return true;
    }

    return isFirstLaunch;
  }

  Future<void> setFirstLaunch({required bool isFirstLaunch}) async {
    final prefs = SharedPreferencesAsync();

    await prefs.setBool(_firstLaunchKey, isFirstLaunch);
  }

  Future<int?> getBirthday() async {
    final prefs = SharedPreferencesAsync();
    final birthday = await prefs.getInt(_birthdayKey);

    if (birthday == null) {
      logger.d('Birthday from prefs is null');
    }

    return birthday;
  }

  Future<void> setBirthday(int birthday) async {
    final prefs = SharedPreferencesAsync();

    await prefs.setInt(_birthdayKey, birthday);
  }

  Future<int?> getLifespan() async {
    final prefs = SharedPreferencesAsync();

    final lifespan = await prefs.getInt(_lifespanKey);

    if (lifespan != null) {
      logger.d('Lifespan from prefs is null');
    }

    return lifespan;
  }

  Future<void> setLifespan(int lifespan) async {
    final prefs = SharedPreferencesAsync();

    await prefs.setInt(_lifespanKey, lifespan);
  }
}
