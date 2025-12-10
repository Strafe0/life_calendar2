import 'dart:io';
import 'dart:ui' show Locale;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:life_calendar/core/l10n/app_localizations.dart';
import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/data/services/notifications/local_notification_id_enum.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  // Main plugin instance
  final _plugin = FlutterLocalNotificationsPlugin();

  // Initialization logic
  Future<void> initialize() async {
    // 1. Initialize Timezones (needed for scheduled notifications)
    tz.initializeTimeZones();

    // 2. Android Initialization
    // 'notification_icon' must exist in android/app/src/main/res/drawable
    const androidSettings = AndroidInitializationSettings('notification_icon');

    // 3. iOS Initialization
    // We request permissions manually later, so requestAlert/Badge/Sound are false initially
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // 4. Finalize initialization
    await _plugin.initialize(initSettings);
  }

  /// Request permissions.
  /// Android 13+ requires manual request. iOS always requires it.
  Future<bool?> requestPermissions() async {
    if (Platform.isIOS) {
      final iosImplementation =
          _plugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >();
      return await iosImplementation?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final androidImplementation =
          _plugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      // For Android 13+ (API 33+)
      return await androidImplementation?.requestNotificationsPermission();
    }
    return false;
  }

  /// Проверка и запрос прав на точные будильники (Android 12+)
  Future<void> requestExactAlarmsPermission() async {
    if (Platform.isAndroid) {
      final androidImplementation =
          _plugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      // Проверяем, можем ли мы планировать точные уведомления
      final bool? granted =
          await androidImplementation?.canScheduleExactNotifications();

      // Если прав нет — запрашиваем (откроется диалог или настройки)
      if (granted == false) {
        await androidImplementation?.requestExactAlarmsPermission();
      }
    }
  }

  /// Show an instant notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'main_channel', // Channel ID
      'Main Channel', // Channel Name
      channelDescription: 'For generic notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(id, title, body, details);
  }

  /// Schedule a notification for a future time
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // Если нужно, чтобы повторялось (например, каждый день в это время):
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> scheduleWeeklyReview(Locale locale) async {
    final l10n = lookupAppLocalizations(locale);

    final now = DateTime.now();
    final daysUntilSunday = DateTime.sunday - now.weekday;
    DateTime scheduledDate = DateTime(
      now.year,
      now.month,
      now.day + daysUntilSunday,
      20,
      0,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    const androidDetails = AndroidNotificationDetails(
      'weekly_review_channel',
      'Weekly Review',
      channelDescription: 'Reminders to review your week',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _plugin.zonedSchedule(
      LocalNotificationId.sumUpWeek.id,
      l10n.notificationWeeklyReviewTitle,
      l10n.notificationWeeklyReviewBody,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );

    logger.i('Set weekly notification');
  }

  Future<void> cancelWeeklyReview() async {
    await _plugin.cancel(LocalNotificationId.sumUpWeek.id);
    logger.i('Canceled weekly notification');
  }

  /// Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }
}
