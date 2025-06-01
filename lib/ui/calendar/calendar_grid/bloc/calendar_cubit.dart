import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/repositories/week_repository/week_repository.dart';
import 'package:life_calendar2/data/services/shared_preferences_service.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/models/week/week_box/week_box.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/bloc/calendar_state.dart';
import 'package:life_calendar2/utils/calendar/calendar_size.dart';
import 'package:life_calendar2/utils/result.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final WeekRepository _weekRepository;
  final SharedPreferencesService _sharedPreferencesService;

  CalendarCubit({
    required WeekRepository weekRepository,
    required SharedPreferencesService sharedPreferencesService,
  }) : _weekRepository = weekRepository,
       _sharedPreferencesService = sharedPreferencesService,
       super(const CalendarInitial());

  Future<void> getWeeks({required CalendarSize calendarSize}) async {
    emit(const CalendarLoading());

    final weeksResult = await _weekRepository.getWeeks();

    switch (weeksResult) {
      case Ok<List<Week>>():
        logger.d('Got ${weeksResult.value.length} weeks');

        if (weeksResult.value.isEmpty) {
          final isFirstLaunch = await _sharedPreferencesService.isFirstLaunch();
          if (!isFirstLaunch) {
            logger.e('Week list is empty and it is not first launch');
          }
        }

        emit(
          CalendarSuccess(
            weeks: _prepareWeekBoxes(weeksResult.value, calendarSize),
          ),
        );
      case Error<List<Week>>():
        logger.e('Failed to get weeks', error: weeksResult.error);
        emit(CalendarFailure(weeksResult.error));
    }
  }

  List<WeekBox> _prepareWeekBoxes(List<Week> weeks, CalendarSize calendarSize) {
    final y0 =
        calendarSize.vrtPadding +
        calendarSize.labelVrtPadding +
        calendarSize.weekBoxSide / 2;

    int yearId = 0;
    int previousYearsWeekCount = 0;
    int weekInYearCount = 0;

    return List.generate(weeks.length, growable: false, (weekId) {
      weekInYearCount++;

      final x0 =
          calendarSize.horPadding +
          calendarSize.labelHorPadding +
          calendarSize.weekBoxSide / 2;
      final y =
          y0 +
          yearId * (calendarSize.weekBoxSide + calendarSize.weekBoxPaddingY);

      final x =
          x0 +
          (weekId - previousYearsWeekCount) *
              (calendarSize.weekBoxSide + calendarSize.weekBoxPaddingX);

      final Rect rect = Rect.fromCenter(
        center: Offset(x, y),
        width: calendarSize.weekBoxSide,
        height: calendarSize.weekBoxSide,
      );

      if (weekId + 1 < weeks.length && weeks[weekId + 1].yearId > yearId) {
        previousYearsWeekCount += weekInYearCount;
        weekInYearCount = 0;
        yearId++;
      }

      return WeekBox(
        weekId: weeks[weekId].id,
        yearId: weeks[weekId].yearId,
        tense: weeks[weekId].tense,
        assessment: weeks[weekId].assessment,
        rect: rect,
      );
    });
  }
}
