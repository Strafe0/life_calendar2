import 'package:life_calendar2/domain/models/week/event/event.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/utils/result.dart';

abstract class WeekRepository {
  Future<Result<List<Week>>> getWeeks();

  Future<Result<Week>> getWeek(String id);

  Future<Result<void>> insertWeek(List<Week> weeks);

  Future<Result<Week>> getCurrentWeek();

  Future<Result<void>> updateAssessment({
    required String weekId,
    required WeekAssessment assessment,
  });

  Future<Result<void>> updateEvents({
    required String weekId,
    required List<Event> events,
  });

  Future<Result<void>> updateGoals({
    required String weekId,
    required List<Goal> goals,
  });

  Future<Result<void>> updateResume({
    required String weekId,
    required String resume,
  });

  Future<Result<void>> updatePhotos({
    required String weekId,
    required List<String> photos,
  });
}
