import 'package:life_calendar2/core/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  const SharedPreferencesService();

  static const _firstLaunchKey = 'firstTime';
  static const _birthdayKey = 'birthday';
  static const _lifespanKey = 'lifespan';
  static const _userIdKey = 'user_id';

  Future<bool> isFirstLaunch() async {
    try {
      final prefs = SharedPreferencesAsync();

      final isFirstLaunch = await prefs.getBool(_firstLaunchKey);

      if (isFirstLaunch == null) {
        logger.d('isFirstLaunch from prefs is null');
        return true;
      }

      return isFirstLaunch;
    } catch (e, s) {
      logger.e('SharedPrefs error', error: e, stackTrace: s);
      return true;
    }
  }

  Future<void> setFirstLaunch({required bool isFirstLaunch}) async {
    try {
      final prefs = SharedPreferencesAsync();

      await prefs.setBool(_firstLaunchKey, isFirstLaunch);
    } catch (e, s) {
      logger.e('SharedPrefs error', error: e, stackTrace: s);
    }
  }

  Future<int?> getBirthday() async {
    try {
      final prefs = SharedPreferencesAsync();
      final birthday = await prefs.getInt(_birthdayKey);

      if (birthday == null) {
        logger.d('Birthday from prefs is null');
      }

      return birthday;
    } catch (e, s) {
      logger.e('SharedPrefs error', error: e, stackTrace: s);
      return null;
    }
  }

  Future<void> setBirthday(int birthday) async {
    try {
      final prefs = SharedPreferencesAsync();

      await prefs.setInt(_birthdayKey, birthday);
    } catch (e, s) {
      logger.e('SharedPrefs error', error: e, stackTrace: s);
    }
  }

  Future<int?> getLifespan() async {
    try {
      final prefs = SharedPreferencesAsync();

      final lifespan = await prefs.getInt(_lifespanKey);

      if (lifespan == null) {
        logger.d('Lifespan from prefs is null');
      }

      return lifespan;
    } catch (e, s) {
      logger.e('SharedPrefs error', error: e, stackTrace: s);
      return null;
    }
  }

  Future<void> setLifespan(int lifespan) async {
    try {
      final prefs = SharedPreferencesAsync();

      await prefs.setInt(_lifespanKey, lifespan);
    } catch (e, s) {
      logger.e('SharedPrefs error', error: e, stackTrace: s);
    }
  }

  Future<String?> getUserId() async {
    try {
      final prefs = SharedPreferencesAsync();

      final userId = await prefs.getString(_userIdKey);

      if (userId == null) {
        logger.d('UserId from prefs is null');
      }

      return userId;
    } catch (e, s) {
      logger.e('SharedPrefs error', error: e, stackTrace: s);
      return null;
    }
  }

  Future<void> setUserId(String userId) async {
    try {
      final prefs = SharedPreferencesAsync();

      await prefs.setString(_userIdKey, userId);
    } catch (e, s) {
      logger.e('SharedPrefs error', error: e, stackTrace: s);
    }
  }
}
