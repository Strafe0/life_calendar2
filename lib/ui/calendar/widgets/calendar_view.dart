import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/domain/repositories/week_repository.dart';
import 'package:life_calendar2/ui/calendar/bloc/calendar_cubit.dart';
import 'package:life_calendar2/ui/calendar/bloc/calendar_state.dart';
import 'package:life_calendar2/ui/calendar/widgets/calendar_view_body.dart';
import 'package:life_calendar2/ui/calendar/widgets/calendar_view_failure_body.dart';
import 'package:life_calendar2/ui/calendar/widgets/calendar_view_loading_body.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              CalendarCubit(weekRepository: context.read<WeekRepository>())
                ..getWeeks(),
      child: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          return switch (state) {
            CalendarInitial() ||
            CalendarLoading() => const CalendarViewLoadingBody(),
            CalendarFailure() => const CalendarViewFailureBody(),
            CalendarSuccess() => CalendarViewBody(weeks: state.weeks),
          };
        },
      ),
    );
  }
}
