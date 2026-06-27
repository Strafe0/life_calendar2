/// Updates the native Home Screen widget. The current locale is resolved by the
/// implementation (a platform concern), so callers don't pass it.
abstract interface class HomeWidgetService {
  Future<void> updateProgress({
    required int currentWeekNumber,
    required int totalWeeksCount,
    required int currentWeekGoalsCount,
    required int currentWeekEventsCount,
  });

  Future<void> updateGoalsCount({required int goalsCount});

  Future<void> updateEventsCount({required int eventsCount});
}
