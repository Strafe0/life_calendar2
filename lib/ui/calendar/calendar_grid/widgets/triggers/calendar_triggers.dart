enum CalendarTrigger { search, haptic, currentWeek }

class Triggers {
  final Set<CalendarTrigger> _activatedTriggers = {};

  void activate(CalendarTrigger t) => _activatedTriggers.add(t);

  void reset() => _activatedTriggers.clear();

  bool get search => _activatedTriggers.contains(CalendarTrigger.search);
  bool get haptic => _activatedTriggers.contains(CalendarTrigger.haptic);
  bool get currentWeek =>
      _activatedTriggers.contains(CalendarTrigger.currentWeek);
}
