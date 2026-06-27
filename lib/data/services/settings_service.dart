import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  const SettingsService();

  static const String _kWeeklyReminderKey = 'is_weekly_reminder_enabled';

  /// Whether notifications are enabled (defaults to true)
  Future<bool> isWeeklyReminderEnabled() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_kWeeklyReminderKey) ?? true;
  }

  /// Persists the user's choice
  Future<void> setWeeklyReminderEnabled({required bool isEnabled}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kWeeklyReminderKey, isEnabled);
  }
}
