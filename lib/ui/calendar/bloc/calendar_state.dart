import 'package:life_calendar2/domain/models/week/week_box/week_box.dart';

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
  const CalendarSuccess({required this.weeks});

  final List<WeekBox> weeks;
}

final class CalendarFailure extends CalendarState {
  const CalendarFailure(this.exception);

  final Exception exception;
}
