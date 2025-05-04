import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:life_calendar2/domain/models/week/event/event.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/domain/models/week/week_tense/week_tense.dart';

part 'week.freezed.dart';

part 'week.g.dart';

@freezed
abstract class Week with _$Week {
  const factory Week({
    required int id,
    required int yearId,
    required DateTime start,
    required DateTime end,
    required WeekTense tense,
    required WeekAssessment assessment,
    required List<Goal> goals,
    required List<Event> events,
    required String resume,
    required List<String> photos,
  }) = _Week;

  factory Week.fromJson(Map<String, dynamic> json) => _$WeekFromJson(json);
}
