import 'package:flutter/material.dart';

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
}
