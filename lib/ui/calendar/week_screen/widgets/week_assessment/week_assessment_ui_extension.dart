import 'package:flutter/material.dart';
import 'package:life_calendar/core/l10n/app_localizations.dart';
import 'package:life_calendar/domain/models/week/week_assessment/week_assessment.dart';

extension WeekAssessmentUiExtension on WeekAssessment {
  String label(AppLocalizations l10n) {
    return switch (this) {
      WeekAssessment.good => l10n.assessmentGood,
      WeekAssessment.poor => l10n.assessmentPoor,
      WeekAssessment.bad => l10n.assessmentBad,
    }.replaceAll(' ', '\n');
  }

  Color get color {
    switch (this) {
      case WeekAssessment.good:
        return Colors.green.shade700;
      case WeekAssessment.poor:
        return Colors.grey.shade700;
      case WeekAssessment.bad:
        return Colors.red.shade700;
    }
  }
}
