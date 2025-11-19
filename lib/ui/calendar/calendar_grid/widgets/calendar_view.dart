import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/bloc/calendar_cubit.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/bloc/calendar_state.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_view_body.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_view_failure_body.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_view_loading_body.dart';
import 'package:life_calendar2/ui/user/bloc/user_bloc.dart';
import 'package:life_calendar2/ui/user/bloc/user_state.dart';
import 'package:life_calendar2/utils/calendar/calendar_size.dart';
import 'package:life_calendar2/utils/device_type.dart' as device_type;

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarSize? _calendarSize;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCalendar();
    });
  }

  void _loadCalendar() {
    final brightness = Theme.of(context).brightness;
    final userState = context.read<UserBloc>().state;

    if (userState is! UserSuccess) return;

    final yearsCount = userState.user.lifeSpan;
    logger.d('_loadCalendar, yearsCount: $yearsCount');

    final renderObject = context.findRenderObject();
    final constraints =
        renderObject is RenderBox ? renderObject.constraints : null;

    if (constraints == null) return;

    final deviceType = device_type.getDeviceType();
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

    _calendarSize = calendarSize;

    context.read<CalendarCubit>().getWeeks(
      calendarSize: calendarSize,
      brightness: brightness,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          _loadCalendar();
        }
      },
      child: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          if (_calendarSize == null) {
            return const CalendarViewLoadingBody();
          }

          return switch (state) {
            CalendarInitial() ||
            CalendarLoading() => const CalendarViewLoadingBody(),
            CalendarFailure() => const CalendarViewFailureBody(),
            CalendarSuccess() => CalendarViewBody(
              weekBoxes: state.weeks,
              calendarSize: _calendarSize!,
              lastUpdateTime: state.lastUpdateTime,
            ),
          };
        },
      ),
    );
  }
}
