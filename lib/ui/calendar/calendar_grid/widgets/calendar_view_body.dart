import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/models/week/week_box/week_box.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_painter.dart';
import 'package:life_calendar2/utils/calendar/calendar_size.dart';

class CalendarViewBody extends StatelessWidget {
  const CalendarViewBody({
    super.key,
    required this.weekBoxes,
    required this.calendarSize,
  });

  final List<WeekBox> weekBoxes;
  final CalendarSize calendarSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _onCalendarTap(context, details, calendarSize),
      child: CustomPaint(
        size: Size.infinite,
        painter: CalendarPainter(
          weekBoxes: weekBoxes,
          calendarSize: calendarSize,
          textColor: Theme.of(context).colorScheme.onSurface,
          brightness: Theme.of(context).brightness,
        ),
      ),
    );
  }

  void _onCalendarTap(
    BuildContext context,
    TapDownDetails details,
    CalendarSize calendarSize,
  ) {
    final position = details.localPosition;

    final weekId =
        weekBoxes
            .firstWhere(
              (weekRect) =>
                  weekRect.rect.left <= position.dx &&
                  position.dx <= weekRect.rect.right &&
                  weekRect.rect.top <= position.dy &&
                  position.dy <= weekRect.rect.bottom,
              orElse: WeekBox.empty,
            )
            .weekId;

    logger.i('Tapped on $weekId week');
    if (weekId != -1) {
      context.push('/calendar/week/$weekId');
    }
  }
}
