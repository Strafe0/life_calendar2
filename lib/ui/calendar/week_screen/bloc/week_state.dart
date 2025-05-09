import 'package:life_calendar2/domain/models/week/event/event.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/domain/models/week/week_tense/week_tense.dart';

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

  WeekSuccess copyWith({
    WeekTense? tense,
    WeekAssessment? assessment,
    List<Goal>? goals,
    List<Event>? events,
    List<String>? photos,
    String? resume,
  }) {
    return WeekSuccess(
      week: week.copyWith(
        tense: tense ?? week.tense,
        assessment: assessment ?? week.assessment,
        goals: goals ?? week.goals,
        events: events ?? week.events,
        photos: photos ?? week.photos,
        resume: resume ?? week.resume,
      ),
    );
  }
}

final class WeekFailure extends WeekState {
  final Exception exception;

  const WeekFailure(this.exception);
}
