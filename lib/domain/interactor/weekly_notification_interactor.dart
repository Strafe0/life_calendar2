import 'dart:ui' show PlatformDispatcher;
import 'package:life_calendar2/core/logger/logger.dart';
import 'package:life_calendar2/data/services/notifications/local_notification_service.dart';
import 'package:life_calendar2/data/services/settings_service.dart';
import 'package:life_calendar2/utils/result.dart';

class WeeklyNotificationInteractor {
  final LocalNotificationService _notificationService;
  final SettingsService _settingsService;

  WeeklyNotificationInteractor(
    this._notificationService,
    this._settingsService,
  );

  Future<void> initializeWithPermissions() async {
    await _notificationService.initialize();
    await _notificationService.requestPermissions();
    await _notificationService.requestExactAlarmsPermission();
  }

  Future<void> checkAndScheduleAtStartup() async {
    try {
      final isEnabled = await _settingsService.isWeeklyReminderEnabled();
      await _syncNotificationState(isEnabled: isEnabled);
    } catch (e, s) {
      logger.e(
        'Failed to check and schedule weekly notification',
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<Result<void>> toggleNotification({required bool isEnabled}) async {
    try {
      await _settingsService.setWeeklyReminderEnabled(isEnabled: isEnabled);
      await _syncNotificationState(isEnabled: isEnabled);

      return const Result.ok(null);
    } catch (e, s) {
      logger.e(
        'Failed to set $isEnabled for weekly notification',
        error: e,
        stackTrace: s,
      );

      return Result.error(e);
    }
  }

  Future<void> _syncNotificationState({required bool isEnabled}) async {
    final isEnabled = await _settingsService.isWeeklyReminderEnabled();

    if (!isEnabled) return _notificationService.cancelWeeklyReview();

    await _notificationService.scheduleWeeklyReview(
      PlatformDispatcher.instance.locale,
    );
  }
}
