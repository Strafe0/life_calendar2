import 'package:life_calendar/domain/models/week/event/event.dart';
import 'package:life_calendar/domain/models/week/goal/goal.dart';
import 'package:life_calendar/domain/models/week/week.dart';
import 'package:life_calendar/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar/utils/result.dart';

abstract class WeekRepository {
  Future<Result<List<Week>>> getWeeks();

  Future<Result<Week>> getWeek(int id);

  Future<Result<void>> insertWeeks(List<Week> weeks);

  Future<Result<Week>> getCurrentWeek();

  Future<Result<Week>> updateCurrentWeek();

  Future<Result<void>> updateAssessment({
    required int weekId,
    required WeekAssessment assessment,
  });

  Future<Result<void>> updateEvents({
    required int weekId,
    required List<Event> events,
  });

  Future<Result<void>> updateGoals({
    required int weekId,
    required List<Goal> goals,
  });

  Future<Result<void>> updateResume({
    required int weekId,
    required String resume,
  });

  Future<Result<void>> updatePhotos({
    required int weekId,
    required List<String> photos,
  });

  Future<Result<bool>> hasChangesInRange({
    required int startYearId,
    required int endYearId,
  });
}
