import 'package:flutter/material.dart';
import 'package:life_calendar/domain/models/week/week.dart';
import 'package:life_calendar/ui/core/themes/week_extension.dart';

class WeekBox {
  final int weekId;
  final int yearId;
  final RRect rect;
  final Week week;

  const WeekBox({
    required this.weekId,
    required this.yearId,
    required this.rect,
    required this.week,
  });

  WeekBox.empty()
    : weekId = -1,
      yearId = -1,
      rect = RRect.zero,
      week = Week.empty();

  factory WeekBox.fromWeek({required Week week, required RRect rect}) {
    return WeekBox(
      weekId: week.id,
      yearId: week.yearId,
      rect: rect,
      week: week,
    );
  }

  /// Resolves the box color for the given [brightness] at paint time, keeping
  /// theme-dependent presentation out of the cubit that builds the boxes.
  Color color({required Brightness brightness}) =>
      week.getColor(brightness: brightness);
}
