import 'package:equatable/equatable.dart';
import 'package:life_calendar/core/extensions/date_time/date_time_extension.dart';
import 'package:life_calendar/ui/calendar/calendar_grid/models/week_box.dart';

sealed class CalendarState {
  const CalendarState();
}

final class CalendarInitial extends CalendarState {
  const CalendarInitial();
}

final class CalendarLoading extends CalendarState {
  const CalendarLoading();
}

final class CalendarSuccess extends CalendarState with Equatable {
  final List<WeekBox> weeks;
  final DateTime lastUpdateTime;

  const CalendarSuccess({required this.weeks, required this.lastUpdateTime});

  @override
  String toString() =>
      'CalendarSuccess(weeks: ${weeks.length}, '
      'lastUpdate: ${lastUpdateTime.toTimeStamp()})';

  // lastUpdateTime is intentionally part of the value: it also drives
  // CalendarPainter.shouldRepaint, since weekBoxes is compared only by length.
  @override
  List<Object?> get props => [weeks, lastUpdateTime];
}

final class CalendarFailure extends CalendarState with Equatable {
  final Object exception;

  const CalendarFailure(this.exception);

  @override
  List<Object?> get props => [exception];
}
