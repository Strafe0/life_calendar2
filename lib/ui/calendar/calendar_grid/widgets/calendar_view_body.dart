import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/core/navigation/app_routes.dart';
import 'package:life_calendar2/domain/models/week/week_box/week_box.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_interactive_viewer.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_painter.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/search/search_pull_indicator.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/search/search_utils.dart';
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

  @override
  State<CalendarViewBody> createState() => _CalendarViewBodyState();
}

class _CalendarViewBodyState extends State<CalendarViewBody> {
  final _transformationController = TransformationController();
  final _topNotifier = ValueNotifier<double>(0);
  bool _isSearchTriggered = false;
  bool _isHapticTriggered = false;

  static const _searchTriggerThreshold = 100.0;

  @override
  Widget build(BuildContext context) {
    logger.d('Build CalendarViewBody');
    return GestureDetector(
      onTapUp:
          (details) => _onCalendarTap(
            context,
            _transformationController.toScene(details.localPosition),
            widget.calendarSize,
          ),
      child: CalendarInteractiveViewer(
        controller: _transformationController,
        onDragStart: () {
          _isSearchTriggered = false;
          _isHapticTriggered = false;
        },
        onDrag: (dragDistance) {
          _topNotifier.value = dragDistance;
          if (dragDistance > _searchTriggerThreshold) {
            if (!_isHapticTriggered) {
              HapticFeedback.lightImpact();
              _isHapticTriggered = true;
            }

            _isSearchTriggered = true;
          }
        },
        onDragEnd: () {
          if (_isSearchTriggered) {
            showSearchSheet(context);
          }
        },
        child: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: _topNotifier,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -_searchTriggerThreshold + value),
                  child: SearchPullIndicator(
                    isSearchTriggered: _isSearchTriggered,
                    height: _searchTriggerThreshold,
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: _topNotifier,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: child,
                );
              },
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
          ],
        ),
      ),
    );
  }

  void _onCalendarTap(
    BuildContext context,
    Offset position,
    CalendarSize calendarSize,
  ) {
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

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }
}
