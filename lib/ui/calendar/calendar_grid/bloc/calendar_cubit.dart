import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/repositories/week_repository/week_repository.dart';
import 'package:life_calendar2/data/services/shared_preferences_service.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/models/week/week_box/week_box.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/bloc/calendar_state.dart';
import 'package:life_calendar2/ui/core/themes/week_extension.dart';
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

  Future<void> getWeeks({
    required CalendarSize calendarSize,
    required Brightness brightness,
  }) async {
    emit(const CalendarLoading());

    final updateCurrWeekResult = await _weekRepository.updateCurrentWeek();
    if (updateCurrWeekResult is Error) {
      logger.w(
        'Failed to update current week in DB',
        error: updateCurrWeekResult.error,
      );
    }

    final weeksResult = await _weekRepository.getWeeks();

    switch (weeksResult) {
      case Ok<List<Week>>():
        logger.d('Got ${weeksResult.value.length} weeks');

        if (weeksResult.value.isEmpty) {
          final isFirstLaunch = await _sharedPreferencesService.isFirstLaunch();
          if (!isFirstLaunch) {
            logger.e('Week list is empty and it is not first launch');
            emit(CalendarFailure(Exception('No data')));
          }
        }

        emit(
          CalendarSuccess(
            weeks: _prepareWeekBoxes(
              weeksResult.value,
              calendarSize,
              brightness,
            ),
            lastUpdateTime: DateTime.now(),
          ),
        );
      case Error<List<Week>>():
        logger.e('Failed to get weeks', error: weeksResult.error);
        emit(CalendarFailure(weeksResult.error));
    }
  }

  void updateWeek({required Week week}) {
    if (state is CalendarSuccess) {
      final weeks = (state as CalendarSuccess).weeks;
      final weekBox = (state as CalendarSuccess).weeks.firstWhere(
        (w) => w.weekId == week.id,
        orElse: () => const WeekBox.empty(),
      );
      if (weekBox.weekId > 1) {
        weeks[weekBox.weekId - 1] = WeekBox.fromWeek(
          week: week,
          rect: weekBox.rect,
        );
        emit(CalendarSuccess(weeks: weeks, lastUpdateTime: DateTime.now()));
      }
    }
  }

  List<WeekBox> _prepareWeekBoxes(
    List<Week> weeks,
    CalendarSize calendarSize,
    Brightness brightness,
  ) {
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

      final rrect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(x, y),
          width: calendarSize.weekBoxSide,
          height: calendarSize.weekBoxSide,
        ),
        const Radius.circular(1.5),
      );

      if (weekId + 1 < weeks.length && weeks[weekId + 1].yearId > yearId) {
        previousYearsWeekCount += weekInYearCount;
        weekInYearCount = 0;
        yearId++;
      }

      return WeekBox(
        weekId: weeks[weekId].id,
        yearId: weeks[weekId].yearId,
        colorLight: weeks[weekId].getColor(brightness: Brightness.light),
        colorDark: weeks[weekId].getColor(brightness: Brightness.dark),
        rect: rrect,
      );
    });
  }

  Future<bool> hasChangedWeeks({required int newLifeSpan}) async {
    final oldLifeSpan = await _sharedPreferencesService.getLifespan();

    if (oldLifeSpan == null) {
      logger.w('Failed to check changed weeks, because old lifespan is null');
      return false;
    }

    final result = await _weekRepository.hasChangesInRange(
      startYearId: math.min(oldLifeSpan, newLifeSpan),
      endYearId: math.max(oldLifeSpan, newLifeSpan),
    );

    return switch (result) {
      Ok<bool>() => result.value,
      _ => false,
    };
  }
}
