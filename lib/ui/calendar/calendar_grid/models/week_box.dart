import 'package:flutter/material.dart';
import 'package:life_calendar/domain/models/week/week.dart';
import 'package:life_calendar/ui/core/themes/week_extension.dart';

class WeekBox {
  final int weekId;
  final int yearId;
  final Color colorLight;
  final Color colorDark;
  final RRect rect;

  const WeekBox({
    required this.weekId,
    required this.yearId,
    required this.colorLight,
    required this.colorDark,
    required this.rect,
  });

  const WeekBox.empty()
    : weekId = -1,
      yearId = -1,
      colorLight = const Color(0xFFFFFFFF),
      colorDark = const Color(0xFF000000),
      rect = RRect.zero;

  factory WeekBox.fromWeek({required Week week, required RRect rect}) {
    return WeekBox(
      weekId: week.id,
      yearId: week.yearId,
      colorLight: week.getColor(brightness: Brightness.light),
      colorDark: week.getColor(brightness: Brightness.dark),
      rect: rect,
    );
  }
}
