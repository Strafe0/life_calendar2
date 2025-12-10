import 'package:life_calendar/core/extensions/date_time/date_time_extension.dart';
import 'package:life_calendar/domain/models/week/week_box/week_box.dart';

sealed class CalendarState {
  const CalendarState();
}

final class CalendarInitial extends CalendarState {
  const CalendarInitial();
}

final class CalendarLoading extends CalendarState {
  const CalendarLoading();
}

final class CalendarSuccess extends CalendarState {
  final List<WeekBox> weeks;
  final DateTime lastUpdateTime;

  const CalendarSuccess({required this.weeks, required this.lastUpdateTime});

  @override
  String toString() =>
      'CalendarSuccess(weeks: ${weeks.length}, '
      'lastUpdate: ${lastUpdateTime.toTimeStamp()})';
}

final class CalendarFailure extends CalendarState {
  final Object exception;

  const CalendarFailure(this.exception);
}
