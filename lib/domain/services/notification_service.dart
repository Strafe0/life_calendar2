import 'dart:ui' show Locale;

/// Schedules and cancels the app's local notifications. Keeps the
/// notification-plugin dependency out of the domain layer so interactors depend
/// on this abstraction instead of the concrete `LocalNotificationService`.
abstract interface class NotificationService {
  Future<void> initialize();

  Future<void> requestPermissions();

  Future<void> requestExactAlarmsPermission();

  Future<void> scheduleWeeklyReview(Locale locale);

  Future<void> cancelWeeklyReview();
}
