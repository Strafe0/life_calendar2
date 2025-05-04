import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/ui/calendar/widgets/calendar_painter.dart';
import 'package:life_calendar2/utils/calendar/calendar_size.dart';
import 'package:life_calendar2/utils/device_type.dart' as device_type;

class CalendarViewBody extends StatelessWidget {
  const CalendarViewBody({super.key, required this.weeks});

  final List<Week> weeks;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = device_type.getDeviceType();

        final yearsCount = weeks.last.yearId;

        final calendarSize = switch (deviceType) {
          device_type.DeviceType.phone => CalendarSize.forPhone(
            constraints.maxWidth,
            constraints.maxHeight,
            yearsCount,
          ),
          device_type.DeviceType.tablet => CalendarSize.forTablet(
            constraints.maxWidth,
            constraints.maxHeight,
            yearsCount,
          ),
        };

        return CustomPaint(
          painter: CalendarPainter(
            weeks: weeks,
            calendarSize: calendarSize,
            textColor: Theme.of(context).colorScheme.onSurface,
            brightness: Theme.of(context).brightness,
          ),
        );
      },
    );
  }
}
