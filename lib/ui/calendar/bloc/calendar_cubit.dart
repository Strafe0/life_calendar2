import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/repositories/week_repository.dart';
import 'package:life_calendar2/ui/calendar/bloc/calendar_state.dart';
import 'package:life_calendar2/utils/result.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({required WeekRepository weekRepository})
    : _weekRepository = weekRepository,
      super(const CalendarInitial());

  final WeekRepository _weekRepository;

  Future<void> getWeeks() async {
    emit(const CalendarLoading());

    final weeksResult = await _weekRepository.getWeeks();

    switch (weeksResult) {
      case Ok<List<Week>>():
        logger.d('Got ${weeksResult.value.length} weeks');
        emit(CalendarSuccess(weeks: weeksResult.value));
      case Error<List<Week>>():
        logger.e('Failed to get weeks', error: weeksResult.error);
        emit(CalendarFailure(weeksResult.error));
    }
  }
}
