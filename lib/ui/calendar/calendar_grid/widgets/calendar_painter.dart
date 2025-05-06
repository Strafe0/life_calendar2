import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/week/week_box/week_box.dart';
import 'package:life_calendar2/ui/core/themes/week_extension.dart';
import 'package:life_calendar2/utils/calendar/calendar_size.dart';

class CalendarPainter extends CustomPainter {
  final List<WeekBox> weekBoxes;
  final CalendarSize calendarSize;
  final Color textColor;
  final Brightness brightness;

  const CalendarPainter({
    required this.weekBoxes,
    required this.calendarSize,
    required this.textColor,
    required this.brightness,
  });

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    _drawWeekLabels(canvas, textColor);

    int yearId = 0;
    for (int weekId = 0; weekId < weekBoxes.length; weekId++) {
      if (yearId % 5 == 0) {
        _drawYearLabel(yearId, canvas, textColor);
      }

      final RRect rrect = RRect.fromRectAndRadius(
        weekBoxes[weekId].rect,
        const Radius.circular(1.5),
      );

      final week = weekBoxes[weekId];
      final color = week.getColor(brightness: brightness);
      canvas.drawRRect(rrect, Paint()..color = color);

      if (weekId + 1 < weekBoxes.length &&
          weekBoxes[weekId + 1].yearId > yearId) {
        yearId++;
      }
    }
  }

  void _drawWeekLabels(Canvas canvas, Color textColor) {
    for (int i = 0; i < 11; i++) {
      final builder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          fontSize: 10,
          textAlign: TextAlign.center,
          maxLines: 1,
          height: 1,
        ),
      )..pushStyle(ui.TextStyle(color: textColor));

      final String label = (i == 0 ? 1 : i * 5).toString();
      builder.addText(label);
      final ui.Paragraph paragraph =
          builder.build()..layout(
            ui.ParagraphConstraints(width: calendarSize.weekBoxSide * 2),
          );

      final double leftPadding =
          calendarSize.horPadding + calendarSize.labelHorPadding;
      final double k = i == 0 ? 0 : 1;
      canvas.drawParagraph(
        paragraph,
        Offset(
          leftPadding +
              (i * 5 - k) *
                  (calendarSize.weekBoxSide + calendarSize.weekBoxPaddingX) -
              calendarSize.weekBoxSide / 2,
          calendarSize.vrtPadding - calendarSize.weekBoxPaddingX * 2,
        ),
      );
    }
  }

  void _drawYearLabel(int yearNumber, Canvas canvas, Color textColor) {
    final builder =
        ui.ParagraphBuilder(
            ui.ParagraphStyle(
              fontSize: 10,
              textAlign: TextAlign.end,
              maxLines: 1,
              height: 1,
            ),
          )
          ..pushStyle(ui.TextStyle(color: textColor))
          ..addText(yearNumber.toString());

    final ui.Paragraph paragraph =
        builder.build()..layout(
          ui.ParagraphConstraints(width: calendarSize.labelHorPadding),
        );

    final double topPadding =
        calendarSize.vrtPadding + calendarSize.labelVrtPadding;

    canvas.drawParagraph(
      paragraph,
      Offset(
        calendarSize.horPadding - calendarSize.weekBoxPaddingY,
        topPadding +
            yearNumber *
                (calendarSize.weekBoxSide + calendarSize.weekBoxPaddingY),
      ),
    );
  }
}
