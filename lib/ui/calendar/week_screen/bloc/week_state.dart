import 'package:life_calendar2/domain/models/week/week.dart';

sealed class WeekState {
  const WeekState();
}

final class WeekInitial extends WeekState {
  const WeekInitial();
}

final class WeekLoading extends WeekState {
  const WeekLoading();
}

final class WeekSuccess extends WeekState {
  final Week week;

  const WeekSuccess({required this.week});
}

final class WeekFailure extends WeekState {
  final Exception exception;

  const WeekFailure(this.exception);
}