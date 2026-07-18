/// Persists the user's weekly-reminder preference. Lets interactors read and
/// write the flag through a domain abstraction instead of the concrete
/// `SettingsService`.
abstract interface class ReminderSettingsService {
  Future<bool> isWeeklyReminderEnabled();

  Future<void> setWeeklyReminderEnabled({required bool isEnabled});
}
