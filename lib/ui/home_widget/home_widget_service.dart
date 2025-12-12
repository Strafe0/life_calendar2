import 'dart:ui'; // Для Locale
import 'package:home_widget/home_widget.dart';
import 'package:life_calendar/core/l10n/app_localizations.dart';
import 'package:life_calendar/core/logger/logger.dart';

/// Service responsible for updating native Home Screen widgets.
class HomeWidgetService {
  static const String _appGroupId = 'group.com.vgol.life_calendar2';
  static const String _androidWidgetName = 'HomeWidgetProvider';
  // Name of Kind from Swift file
  static const String _iOSWidgetName = 'HomeWidget';

  // Keys for data sharing
  static const String _keyWeeksText = 'id_weeks_text';
  static const String _keyPercentText = 'id_percent_text';
  static const String _keyGoalsText = 'id_goals_text';
  static const String _keyEventsText = 'id_events_text';
  static const String _keyProgressValue = 'id_progress_value';

  /// Updates the full widget state.
  static Future<void> updateProgress({
    required int currentWeekNumber,
    required int totalWeeksCount,
    required int currentWeekGoalsCount,
    required int currentWeekEventsCount,
    required Locale locale,
  }) async {
    final l10n = lookupAppLocalizations(locale);

    final progress =
        ((currentWeekNumber / totalWeeksCount).clamp(0.0, 1.0) * 100).toInt();

    final weeksStr = l10n.widgetWeeksStats(currentWeekNumber, totalWeeksCount);
    final percentStr = l10n.widgetLifeStats(progress);
    final goalsStr = '🎯 ${l10n.widgetGoalsCount(currentWeekGoalsCount)}';
    final eventsStr = '🗓️ ${l10n.widgetEventsCount(currentWeekEventsCount)}';

    try {
      await HomeWidget.setAppGroupId(_appGroupId);

      await Future.wait([
        HomeWidget.saveWidgetData(_keyWeeksText, weeksStr),
        HomeWidget.saveWidgetData(_keyPercentText, percentStr),
        HomeWidget.saveWidgetData(_keyGoalsText, goalsStr),
        HomeWidget.saveWidgetData(_keyEventsText, eventsStr),
        HomeWidget.saveWidgetData(_keyProgressValue, progress),
      ]);

      await _updateWidget();

      logger.d(
        'HomeWidget full update completed for locale: ${locale.languageCode}',
      );
    } catch (e, s) {
      logger.e('Failed to update home widget', error: e, stackTrace: s);
    }
  }

  /// Updates only the goals count text.
  static Future<void> updateGoalsCount({
    required int goalsCount,
    required Locale locale,
  }) async {
    final l10n = lookupAppLocalizations(locale);
    final goalsStr = '🎯 ${l10n.widgetGoalsCount(goalsCount)}';

    try {
      await HomeWidget.setAppGroupId(_appGroupId);
      await HomeWidget.saveWidgetData(_keyGoalsText, goalsStr);
      await _updateWidget();

      logger.d('HomeWidget goals update: "$goalsStr"');
    } catch (e, s) {
      logger.e('Failed to update goals count', error: e, stackTrace: s);
    }
  }

  /// Updates only the events count text.
  static Future<void> updateEventsCount({
    required int eventsCount,
    required Locale locale,
  }) async {
    final l10n = lookupAppLocalizations(locale);
    final eventsStr = '🗓️ ${l10n.widgetEventsCount(eventsCount)}';

    try {
      await HomeWidget.setAppGroupId(_appGroupId);
      await HomeWidget.saveWidgetData(_keyEventsText, eventsStr);
      await _updateWidget();

      logger.d('HomeWidget events update: "$eventsStr"');
    } catch (e, s) {
      logger.e('Failed to update events count', error: e, stackTrace: s);
    }
  }

  /// Internal helper to trigger the update
  static Future<void> _updateWidget() async {
    await HomeWidget.updateWidget(
      name: _androidWidgetName,
      iOSName: _iOSWidgetName,
    );
  }
}
