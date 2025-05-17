import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/repositories/week_repository/week_repository.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/utils/result.dart';

class WeekCubit extends Cubit<WeekState> {
  final WeekRepository _weekRepository;

  WeekCubit({required WeekRepository weekRepository})
    : _weekRepository = weekRepository,
      super(const WeekInitial());

  bool get isLoading => state == const WeekLoading();

  Future<void> getWeek({required int? weekId}) async {
    emit(const WeekLoading());

    if (weekId == null) {
      emit(const WeekFailure(FormatException('Cannot find week with null id')));
      return;
    }

    final weekResult = await _weekRepository.getWeek(weekId);

    switch (weekResult) {
      case Ok<Week>():
        logger.d('Got week $weekId');
        emit(WeekSuccess(week: weekResult.value));
      case Error<Week>():
        emit(WeekFailure(Exception('Failed to get week with id: $weekId')));
        logger.e('Failed to receive week $weekId', error: weekResult.error);
    }
  }

  Future<void> changeAssessment(WeekAssessment newAssessment) async {
    final prevState = state;
    if (prevState is WeekSuccess) {
      emit(prevState.copyWith(assessment: newAssessment));

      final result = await _weekRepository.updateAssessment(
        weekId: prevState.week.id,
        assessment: newAssessment,
      );

      if (result is Error) {
        emit(prevState);
        logger.e(
          'Failed to change assessment. Returning previous state',
          error: result.error,
        );
      }
    } else {
      logger.e('Cannot change assessment, because week is not ready');
    }
  }

  Future<void> toggleGoal({
    required String goalId,
    required bool isCompleted,
  }) async {
    final prevState = state;
    if (prevState is WeekSuccess) {
      final newGoals =
          prevState.week.goals.map((goal) {
            return goal.id == goalId
                ? goal.copyWith(isCompleted: isCompleted)
                : goal;
          }).toList();
      emit(prevState.copyWith(goals: newGoals));

      final result = await _weekRepository.updateGoals(
        weekId: prevState.week.id,
        goals: newGoals,
      );

      if (result is Error) {
        emit(prevState);
        logger.e(
          'Failed to change goal. Returning previous state',
          error: result.error,
        );
      }
    } else {
      logger.e('Cannot change goal, because week is not ready');
    }
  }
}
