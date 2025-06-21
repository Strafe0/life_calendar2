import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/ui/core/themes/week_extension.dart';

class WeekBox {
  final int weekId;
  final int yearId;
  final Color color;
  final RRect rect;

  const WeekBox({
    required this.weekId,
    required this.yearId,
    required this.color,
    required this.rect,
  });

  const WeekBox.empty()
    : weekId = -1,
      yearId = -1,
      color = const Color(0xFFFFFFFF),
      rect = RRect.zero;

  factory WeekBox.fromWeek({
    required Week week,
    required RRect rect,
    required Brightness brightness,
  }) {
    return WeekBox(
      weekId: week.id,
      yearId: week.yearId,
      color: week.getColor(brightness: brightness),
      rect: rect,
    );
  }
}
