import 'package:life_calendar2/domain/models/week/week.dart';

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

  final List<Week> weeks;
}

final class CalendarFailure extends CalendarState {
  const CalendarFailure(this.exception);

  final Exception exception;
}
