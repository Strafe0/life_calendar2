import 'package:flutter/material.dart';
import 'package:life_calendar2/core/l10n/app_localizations.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';

extension WeekAssessmentUiExtension on WeekAssessment {
  String label(AppLocalizations l10n) {
    switch (this) {
      case WeekAssessment.good:
        return l10n.assessmentGood;
      case WeekAssessment.poor:
        return l10n.assessmentPoor;
      case WeekAssessment.bad:
        return l10n.assessmentBad;
    }
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
