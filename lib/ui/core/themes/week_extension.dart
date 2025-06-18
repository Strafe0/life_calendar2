import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/domain/models/week/week_tense/week_tense.dart';
import 'package:life_calendar2/ui/core/themes/app_theme.dart';
import 'package:life_calendar2/ui/core/themes/week_color.dart';

extension WeekColorExtension on Week {
  Color getColor({required Brightness brightness}) {
    final theme =
        brightness == Brightness.light
            ? AppTheme.lightTheme
            : AppTheme.darkTheme;

    return switch (tense) {
      WeekTense.past => switch (assessment) {
        WeekAssessment.good => WeekColor.goodWeekColor,
        WeekAssessment.bad => WeekColor.badWeekColor,
        WeekAssessment.poor => theme.colorScheme.secondary,
      },
      WeekTense.current => Colors.blueAccent,
      WeekTense.future => switch (assessment) {
        WeekAssessment.good => WeekColor.goodWeekColor,
        WeekAssessment.bad => WeekColor.badWeekColor,
        WeekAssessment.poor => theme.colorScheme.secondaryContainer,
      },
    };
  }
}
