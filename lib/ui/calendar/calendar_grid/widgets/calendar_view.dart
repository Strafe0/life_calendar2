import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/domain/repositories/week_repository.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/bloc/calendar_cubit.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/bloc/calendar_state.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_view_body.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_view_failure_body.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_view_loading_body.dart';
import 'package:life_calendar2/ui/user/bloc/user_cubit.dart';
import 'package:life_calendar2/ui/user/bloc/user_state.dart';
import 'package:life_calendar2/utils/calendar/calendar_size.dart';
import 'package:life_calendar2/utils/device_type.dart' as device_type;

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserCubit, UserState, int>(
      selector: (state) {
        return switch (state) {
          UserInitial() || UserLoading() => 0,
          UserFailure() => -1,
          UserSuccess() => state.user.lifeSpan,
        };
      },
      builder: (context, yearsCount) {
        if (yearsCount == 0) {
          return const CalendarViewLoadingBody();
        } else if (yearsCount == -1) {
          return const CalendarViewFailureBody();
        }

        return LayoutBuilder(
          builder: (context, constraints) {
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

            return BlocProvider(
              create:
                  (context) => CalendarCubit(
                    weekRepository: context.read<WeekRepository>(),
                  )..getWeeks(calendarSize: calendarSize),
              child: BlocBuilder<CalendarCubit, CalendarState>(
                builder: (context, state) {
                  return switch (state) {
                    CalendarInitial() ||
                    CalendarLoading() => const CalendarViewLoadingBody(),
                    CalendarFailure() => const CalendarViewFailureBody(),
                    CalendarSuccess() => CalendarViewBody(
                      weekBoxes: state.weeks,
                      calendarSize: calendarSize,
                    ),
                  };
                },
              ),
            );
          },
        );
      },
    );
  }
}
