import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/domain/models/week/week_tense/week_tense.dart';

class WeekBox {
  final int weekId;
  final int yearId;
  final WeekTense tense;
  final WeekAssessment assessment;
  final Rect rect;

  const WeekBox({
    required this.weekId,
    required this.yearId,
    required this.tense,
    required this.assessment,
    required this.rect,
  });

  const WeekBox.empty()
    : weekId = -1,
      yearId = -1,
      tense = WeekTense.past,
      assessment = WeekAssessment.poor,
      rect = Rect.zero;
}
