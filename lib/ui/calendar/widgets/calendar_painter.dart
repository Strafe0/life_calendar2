import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/domain/models/week/week_tense/week_tense.dart';
import 'package:life_calendar2/utils/calendar/calendar_size.dart';

class CalendarPainter extends CustomPainter {
  final List<Week> weeks;
  final CalendarSize calendarSize;
  final Color textColor;
  final Brightness brightness;

  const CalendarPainter({
    required this.weeks,
    required this.calendarSize,
    required this.textColor,
    required this.brightness,
  });

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    final y0 =
        calendarSize.vrtPadding +
        calendarSize.labelVrtPadding +
        calendarSize.weekBoxSide / 2;

    _drawWeekLabels(canvas, textColor);

    int yearId = 0;
    int previousYearsWeekCount = 0;
    int weekInYearCount = 0;
    for (int weekId = 0; weekId < weeks.length; weekId++) {
      weekInYearCount++;

      final x0 =
          calendarSize.horPadding +
          calendarSize.labelHorPadding +
          calendarSize.weekBoxSide / 2;
      final y =
          y0 +
          yearId * (calendarSize.weekBoxSide + calendarSize.weekBoxPaddingY);

      if (yearId % 5 == 0) {
        _drawYearLabel(yearId, canvas, textColor);
      }

      final x =
          x0 +
          (weekId - previousYearsWeekCount) *
              (calendarSize.weekBoxSide + calendarSize.weekBoxPaddingX);

      final Rect rect = Rect.fromCenter(
        center: Offset(x, y),
        width: calendarSize.weekBoxSide,
        height: calendarSize.weekBoxSide,
      );

      final RRect rrect = RRect.fromRectAndRadius(
        rect,
        const Radius.circular(1.5),
      );

      final color = getWeekColor(weeks[weekId], brightness);
      canvas.drawRRect(rrect, Paint()..color = color);

      if (weekId + 1 < weeks.length && weeks[weekId + 1].yearId > yearId) {
        previousYearsWeekCount += weekInYearCount;
        weekInYearCount = 0;
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

  Color getWeekColor(Week week, Brightness brightness) {
    final Color weekColor = switch (week.tense) {
      WeekTense.past => switch (week.assessment) {
        WeekAssessment.good => Colors.green,
        WeekAssessment.bad => Colors.red,
        WeekAssessment.poor => Colors.black54,
      },
      WeekTense.current => Colors.blueAccent,
      WeekTense.future => switch (week.assessment) {
        WeekAssessment.good => Colors.green,
        WeekAssessment.bad => Colors.red,
        WeekAssessment.poor => Colors.grey,
      },
    };

    return weekColor;
  }
}
