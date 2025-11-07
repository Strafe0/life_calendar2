import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/core/navigation/app_routes.dart';
import 'package:life_calendar2/domain/models/week/week_box/week_box.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_painter.dart';
import 'package:life_calendar2/utils/calendar/calendar_size.dart';

// TODO: colors not changed when Brightness changed
class CalendarViewBody extends StatefulWidget {
  const CalendarViewBody({
    super.key,
    required this.weekBoxes,
    required this.calendarSize,
    required this.lastUpdateTime,
  });

  final List<WeekBox> weekBoxes;
  final CalendarSize calendarSize;
  final DateTime lastUpdateTime;

  static const _indicatorSize = 56.0;

  @override
  State<CalendarViewBody> createState() => _CalendarViewBodyState();
}

class _CalendarViewBodyState extends State<CalendarViewBody> {
  final _indicatorController = IndicatorController();
  bool _hapticTriggered = false;

  @override
  Widget build(BuildContext context) {
    logger.d('Build CalendarViewBody');
    return CustomRefreshIndicator(
      controller: _indicatorController,
      offsetToArmed: CalendarViewBody._indicatorSize,
      onStateChanged: (change) {
        if (change.newState.isArmed && !_hapticTriggered) {
          HapticFeedback.lightImpact();
          _hapticTriggered = true;
        }
      },
      onRefresh: () async {
        _hapticTriggered = false;
      },
      builder: (context, child, controller) {
        return Stack(
          children: [
            SizedBox(
              height: CalendarViewBody._indicatorSize * controller.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AnimatedRotation(
                      turns:
                          _indicatorController.isDragging ||
                                  _indicatorController.isIdle
                              ? 0
                              : 1 / 2,
                      duration: const Duration(milliseconds: 100),
                      child: Icon(
                        Icons.arrow_downward,
                        size: 24 * controller.value.clamp(0, 1),
                        color: ColorScheme.of(context).onSurface,
                      ),
                    ),
                  ),
                  if (_indicatorController.isDragging ||
                      _indicatorController.isIdle)
                    const Text('Потяните для поиска')
                  else
                    const Text('Отпустите для поиска'),
                ],
              ),
            ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    controller.value * CalendarViewBody._indicatorSize,
                  ),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
      child: LayoutBuilder(
        builder: (context, constratins) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constratins.maxHeight,
              child: GestureDetector(
                onTapUp:
                    (details) =>
                        _onCalendarTap(context, details, widget.calendarSize),
                child: RepaintBoundary(
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: CalendarPainter(
                      weekBoxes: widget.weekBoxes,
                      calendarSize: widget.calendarSize,
                      lastUpdateTime: widget.lastUpdateTime,
                      textColor: Theme.of(context).colorScheme.onSurface,
                      brightness: Theme.of(context).brightness,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onCalendarTap(
    BuildContext context,
    TapUpDetails details,
    CalendarSize calendarSize,
  ) {
    final position = details.localPosition;

    final weekId =
        widget.weekBoxes
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
      context.push(AppRoute.weekId(weekId));
    }
  }
}
