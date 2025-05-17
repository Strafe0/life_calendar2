import 'package:life_calendar2/data/repositories/week_repository/week_repository.dart';
import 'package:life_calendar2/domain/models/week/event/event.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/domain/models/week/week_tense/week_tense.dart';
import 'package:life_calendar2/utils/calendar/calendar_calculator.dart';
import 'package:life_calendar2/utils/result.dart';

class WeekRepositoryMock implements WeekRepository {
  @override
  Future<Result<Week>> getCurrentWeek() => Future.delayed(
    const Duration(milliseconds: 100),
    () => Result.ok(
      Week(
        id: 1234,
        yearId: 666,
        start: DateTime(2025, 05, 12),
        end: DateTime(2025, 05, 18),
        tense: WeekTense.current,
        assessment: WeekAssessment.poor,
        goals: const [],
        events: const [],
        resume: '',
        photos: const [],
      ),
    ),
  );

  @override
  Future<Result<Week>> getWeek(int id) => Future.delayed(
    const Duration(seconds: 1),
    () => Result.ok(
      Week(
        id: id,
        yearId: 666,
        start: DateTime(2023, 08, 21),
        end: DateTime(2023, 08, 28),
        tense: WeekTense.past,
        assessment: WeekAssessment.good,
        goals: [const Goal(id: '0', title: 'Пожениться', isCompleted: true)],
        events: [
          Event(id: '0', title: 'Свадьба', date: DateTime(2023, 08, 26)),
        ],
        resume: '',
        photos: const [],
      ),
    ),
  );

  @override
  Future<Result<List<Week>>> getWeeks() => Future.delayed(
    const Duration(seconds: 1),
    () => Result.ok(
      CalendarGenerator(
        birthday: DateTime(1998, 12, 22),
        lifeSpan: 80,
      ).generateWeeks(),
    ),
  );

  @override
  Future<Result<void>> insertWeeks(List<Week> weeks) => Future.delayed(
    const Duration(milliseconds: 100),
    () => const Result.ok(null),
  );

  @override
  Future<Result<void>> updateAssessment({
    required int weekId,
    required WeekAssessment assessment,
  }) => Future.delayed(
    const Duration(milliseconds: 100),
    () => const Result.ok(null),
  );

  @override
  Future<Result<void>> updateEvents({
    required int weekId,
    required List<Event> events,
  }) => Future.delayed(
    const Duration(milliseconds: 100),
    () => const Result.ok(null),
  );

  @override
  Future<Result<void>> updateGoals({
    required int weekId,
    required List<Goal> goals,
  }) => Future.delayed(
    const Duration(milliseconds: 100),
    () => const Result.ok(null),
  );

  @override
  Future<Result<void>> updatePhotos({
    required int weekId,
    required List<String> photos,
  }) => Future.delayed(
    const Duration(milliseconds: 100),
    () => const Result.ok(null),
  );

  @override
  Future<Result<void>> updateResume({
    required int weekId,
    required String resume,
  }) => Future.delayed(
    const Duration(milliseconds: 100),
    () => const Result.ok(null),
  );
}
