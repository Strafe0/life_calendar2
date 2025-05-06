import 'package:life_calendar2/domain/models/week/event/event.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/domain/models/week/week_tense/week_tense.dart';
import 'package:life_calendar2/domain/repositories/week_repository.dart';
import 'package:life_calendar2/utils/calendar/calendar_calculator.dart';
import 'package:life_calendar2/utils/result.dart';

class WeekRepositoryMock implements WeekRepository {
  @override
  Future<Result<Week>> getCurrentWeek() {
    // TODO: implement getCurrentWeek
    throw UnimplementedError();
  }

  @override
  Future<Result<Week>> getWeek(int id) async {
    await Future.delayed(const Duration(seconds: 1));

    return Result.ok(
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
    );
  }

  @override
  Future<Result<List<Week>>> getWeeks() async {
    await Future.delayed(const Duration(seconds: 1));

    return Result.ok(
      CalendarGenerator(
        birthday: DateTime(1998, 12, 22),
        lifeSpan: 80,
      ).generateWeeks(),
    );
  }

  @override
  Future<Result<void>> insertWeeks(List<Week> weeks) {
    // TODO: implement insertWeeks
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> updateAssessment({
    required int weekId,
    required WeekAssessment assessment,
  }) {
    // TODO: implement updateAssessment
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> updateEvents({
    required int weekId,
    required List<Event> events,
  }) {
    // TODO: implement updateEvents
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> updateGoals({
    required int weekId,
    required List<Goal> goals,
  }) {
    // TODO: implement updateGoals
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> updatePhotos({
    required int weekId,
    required List<String> photos,
  }) {
    // TODO: implement updatePhotos
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> updateResume({
    required int weekId,
    required String resume,
  }) {
    // TODO: implement updateResume
    throw UnimplementedError();
  }
}
