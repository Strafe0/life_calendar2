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
  final List<WeekBox> weeks;
  final int? selectedWeekId;

  const CalendarSuccess({required this.weeks, this.selectedWeekId});

  CalendarSuccess copyWith({int? selectedWeekId}) {
    return CalendarSuccess(
      weeks: weeks,
      selectedWeekId: selectedWeekId ?? this.selectedWeekId,
    );
  }
}

final class CalendarFailure extends CalendarState {
  final Exception exception;

  const CalendarFailure(this.exception);
}
