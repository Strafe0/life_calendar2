import 'package:life_calendar/domain/services/reminder_settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService implements ReminderSettingsService {
  const SettingsService();

  static const String _kWeeklyReminderKey = 'is_weekly_reminder_enabled';

  /// Whether notifications are enabled (defaults to true)
  @override
  Future<bool> isWeeklyReminderEnabled() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_kWeeklyReminderKey) ?? true;
  }

  /// Persists the user's choice
  @override
  Future<void> setWeeklyReminderEnabled({required bool isEnabled}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kWeeklyReminderKey, isEnabled);
  }
}
