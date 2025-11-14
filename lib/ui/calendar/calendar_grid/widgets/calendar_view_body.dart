import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/core/navigation/app_routes.dart';
import 'package:life_calendar2/domain/models/week/week_box/week_box.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_interactive_viewer.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_painter.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/current_week_indicator.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/search/search_pull_indicator.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/search/search_ui_utils.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/triggers/calendar_triggers.dart';
import 'package:life_calendar2/ui/user/bloc/user_bloc.dart';
import 'package:life_calendar2/ui/user/bloc/user_state.dart';
import 'package:life_calendar2/utils/calendar/calendar_size.dart';
import 'package:life_calendar2/utils/calendar/search_utils.dart';

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
  final _triggers = Triggers();

  static const _indicatorHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    logger.d('Build CalendarViewBody');
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapUp:
              (details) => _onCalendarTap(
                context,
                _transformationController.toScene(details.localPosition),
                widget.calendarSize,
              ),
          child: CalendarInteractiveViewer(
            controller: _transformationController,
            maxDragDistance: _indicatorHeight * 1.5,
            onDragStart: _triggers.reset,
            onDrag: (dragDistance) {
              _topNotifier.value = dragDistance;

              if (dragDistance > _indicatorHeight) {
                if (!_triggers.haptic) {
                  _triggers.activate(CalendarTrigger.haptic);
                  HapticFeedback.lightImpact();
                }

                _triggers.activate(CalendarTrigger.search);
              } else if (dragDistance < -_indicatorHeight) {
                if (!_triggers.haptic) {
                  _triggers.activate(CalendarTrigger.haptic);
                  HapticFeedback.lightImpact();
                }

                _triggers.activate(CalendarTrigger.currentWeek);
              }
            },
            onDragEnd: () {
              if (_triggers.search) {
                showSearchSheet(context);
              } else if (_triggers.currentWeek) {
                _goToCurrentWeek(context);
              }
            },
            child: Stack(
              children: [
                ValueListenableBuilder(
                  valueListenable: _topNotifier,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, -_indicatorHeight + value),
                      child: SearchPullIndicator(
                        isSearchTriggered: _triggers.search,
                        height: _indicatorHeight,
                      ),
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: _topNotifier,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, constraints.maxHeight + value),
                      child: CurrentWeekIndicator(
                        isCurrentWeekTriggered: _triggers.currentWeek,
                        height: _indicatorHeight,
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
      },
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

  void _goToCurrentWeek(BuildContext context) {
    final userState = context.read<UserBloc>().state;
    if (userState is UserSuccess) {
      final user = userState.user;

      final weekId = findWeekIdByDate(
        DateTime.now(),
        birthdate: user.birthdate,
        lifeSpan: user.lifeSpan,
      );

      if (weekId != -1) {
        context.push(AppRoute.weekId(weekId));
      }
    }
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }
}
