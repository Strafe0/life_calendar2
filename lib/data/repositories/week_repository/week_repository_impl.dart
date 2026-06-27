import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/data/repositories/week_repository/week_repository.dart';
import 'package:life_calendar/data/services/database_service.dart';
import 'package:life_calendar/domain/models/week/event/event.dart';
import 'package:life_calendar/domain/models/week/goal/goal.dart';
import 'package:life_calendar/domain/models/week/week.dart';
import 'package:life_calendar/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar/domain/services/image_storage_service.dart';
import 'package:life_calendar/utils/result.dart';

class WeekRepositoryImpl implements WeekRepository {
  final DatabaseService _databaseService;
  final ImageStorageService _imageStorageService;

  const WeekRepositoryImpl({
    required DatabaseService databaseService,
    required ImageStorageService imageStorageService,
  }) : _databaseService = databaseService,
       _imageStorageService = imageStorageService;

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
  Future<Result<Week>> updateCurrentWeek() async {
    try {
      final currentWeek = await _databaseService.advanceCurrentWeekTo(
        DateTime.now(),
      );
      logger.d('New current week in DB: ${currentWeek.id}, ${currentWeek.end}');
      return Result.ok(currentWeek);
    } on Exception catch (e, s) {
      logger.e('Failed to update current week in DB', error: e, stackTrace: s);
      return Result.error(e);
    }
  }

  @override
  Future<Result<Week>> getWeek(int id) async {
    try {
      final week = await _databaseService.getWeek(id);
      final resolvedPhotos = await _imageStorageService.resolvePaths(
        week.photos,
      );

      return Result.ok(week.copyWith(photos: resolvedPhotos));
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
      await _databaseService.insertWeeks(weeks);

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

  @override
  Future<Result<bool>> hasChangesInRange({
    required int startYearId,
    required int endYearId,
  }) async {
    try {
      final hasChanges = await _databaseService.hasChangesInRange(
        startYearId: startYearId,
        endYearId: endYearId,
      );

      return Result.ok(hasChanges);
    } on Exception catch (e, s) {
      logger.e(
        'Failed to check changes in range $startYearId-$endYearId',
        error: e,
        stackTrace: s,
      );

      return Result.error(e);
    }
  }
}
