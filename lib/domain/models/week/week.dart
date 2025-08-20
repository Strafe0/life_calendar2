// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:life_calendar2/core/converters/date_converter.dart';
import 'package:life_calendar2/core/converters/event_converter.dart';
import 'package:life_calendar2/core/converters/goal_converter.dart';
import 'package:life_calendar2/core/converters/photo_converter.dart';
import 'package:life_calendar2/domain/models/week/event/event.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/domain/models/week/week_tense/week_tense.dart';

part 'week.freezed.dart';

part 'week.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
abstract class Week with _$Week {
  const factory Week({
    required int id,
    required int yearId,
    @DateConverter() required DateTime start,
    @DateConverter() required DateTime end,
    @JsonKey(name: 'state') required WeekTense tense,
    required WeekAssessment assessment,
    @GoalConverter() required List<Goal> goals,
    @EventConverter() required List<Event> events,
    required String resume,
    @PhotoConverter() required List<String> photos,
  }) = _Week;

  factory Week.fromJson(Map<String, dynamic> json) => _$WeekFromJson(json);
}
