import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/repositories/week_repository.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/utils/result.dart';

class WeekCubit extends Cubit<WeekState> {
  final WeekRepository _weekRepository;

  WeekCubit({required WeekRepository weekRepository})
    : _weekRepository = weekRepository,
      super(const WeekInitial());

  bool get isLoading => state == const WeekLoading();

  Future<void> getWeek({required int weekId}) async {
    emit(const WeekLoading());

    final weekResult = await _weekRepository.getWeek(weekId);

    switch (weekResult) {
      case Ok<Week>():
        logger.d('Got week $weekId');
        emit(WeekSuccess(week: weekResult.value));
      case Error<Week>():
        logger.e('Failed to receive week $weekId', error: weekResult.error);
    }
  }
}
