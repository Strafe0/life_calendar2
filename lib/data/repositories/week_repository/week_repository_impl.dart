import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/repositories/week_repository/week_repository.dart';
import 'package:life_calendar2/data/services/database_service.dart';
import 'package:life_calendar2/domain/models/week/event/event.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/domain/models/week/week_tense/week_tense.dart';
import 'package:life_calendar2/utils/result.dart';

class WeekRepositoryImpl implements WeekRepository {
  final DatabaseService _databaseService;

  const WeekRepositoryImpl({required DatabaseService databaseService})
    : _databaseService = databaseService;

  @override
  Future<Result<Week>> getCurrentWeek() async {
    try {
      final currentWeek = await _databaseService.getCurrentWeek();

      return Result.ok(currentWeek);
    } on Exception catch (e, s) {
      logger.e('Failed to get current week from DB', error: e, stackTrace: s);
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> updateCurrentWeek() async {
    try {
      final today = DateTime.now();
      final currentWeekResult = await getCurrentWeek();
      switch (currentWeekResult) {
        case Ok():
          await _updateCurrentWeek(today, currentWeekResult.value);
          return const Result.ok(null);
        case Error():
          logger.e(
            'Failed to get current week for updating',
            error: currentWeekResult.error,
          );
          return Result.error(currentWeekResult.error);
      }
    } on Exception catch (e, s) {
      logger.e('Failed to update current week in DB', error: e, stackTrace: s);
      return Result.error(e);
    }
  }

  Future<void> _updateCurrentWeek(DateTime today, Week currentWeek) async {
    logger.d('Updating current week in DB');

    Week currWeekDb = currentWeek;
    while (today.isAfter(currWeekDb.end)) {
      logger.d('Updating week ${currWeekDb.id}, ${currWeekDb.end}');

      await _databaseService.insertWeek(
        currWeekDb.copyWith(tense: WeekTense.past),
      );

      currWeekDb = await _databaseService.getWeek(currWeekDb.id + 1);
    }

    logger.d('New current week in DB: ${currWeekDb.id}, ${currWeekDb.end}');
    await _databaseService.insertWeek(
      currWeekDb.copyWith(tense: WeekTense.current),
    );
  }

  @override
  Future<Result<Week>> getWeek(int id) async {
    try {
      final week = await _databaseService.getWeek(id);

      return Result.ok(week);
    } on Exception catch (e, s) {
      logger.e('Failed to get week $id from DB', error: e, stackTrace: s);
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<Week>>> getWeeks() async {
    try {
      final weeks = await _databaseService.getAllWeeks();
      return Result.ok(weeks);
    } on Exception catch (e, s) {
      logger.e('Failed to get all weeks', error: e, stackTrace: s);
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> insertWeeks(List<Week> weeks) async {
    try {
      await _databaseService.insertAllWeeks(weeks);

      return const Result.ok(null);
    } on Exception catch (e, s) {
      logger.e(
        'Failed to insert ${weeks.length} weeks',
        error: e,
        stackTrace: s,
      );
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> updateAssessment({
    required int weekId,
    required WeekAssessment assessment,
  }) async {
    try {
      await _databaseService.updateAssessment(
        weekId: weekId,
        assessment: assessment,
      );

      return const Result.ok(null);
    } on Exception catch (e, s) {
      logger.e(
        'Failed to update assessment $assessment for week $weekId',
        error: e,
        stackTrace: s,
      );
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> updateEvents({
    required int weekId,
    required List<Event> events,
  }) async {
    try {
      await _databaseService.updateEvents(weekId: weekId, events: events);

      return const Result.ok(null);
    } on Exception catch (e, s) {
      logger.e(
        'Failed to update events for week $weekId',
        error: e,
        stackTrace: s,
      );
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> updateGoals({
    required int weekId,
    required List<Goal> goals,
  }) async {
    try {
      await _databaseService.updateGoals(weekId: weekId, goals: goals);

      return const Result.ok(null);
    } on Exception catch (e, s) {
      logger.e(
        'Failed to update goals for week $weekId',
        error: e,
        stackTrace: s,
      );
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> updatePhotos({
    required int weekId,
    required List<String> photos,
  }) async {
    try {
      await _databaseService.updatePhotos(weekId: weekId, photos: photos);

      return const Result.ok(null);
    } on Exception catch (e, s) {
      logger.e(
        'Failed to update photos for week $weekId',
        error: e,
        stackTrace: s,
      );
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> updateResume({
    required int weekId,
    required String resume,
  }) async {
    try {
      await _databaseService.updateResume(weekId: weekId, resume: resume);

      return const Result.ok(null);
    } on Exception catch (e, s) {
      logger.e(
        'Failed to update resume for week $weekId',
        error: e,
        stackTrace: s,
      );
      return Result.error(e);
    }
  }
}
