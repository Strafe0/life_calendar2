import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_failure_view.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_loading_view.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_view.dart';

class WeekScreen extends StatelessWidget {
  const WeekScreen({super.key, required this.selectedWeekId});

  final int? selectedWeekId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              WeekCubit(weekRepository: context.read())
                ..getWeek(weekId: selectedWeekId),
      child: Builder(
        builder: (context) {
          return BlocBuilder<WeekCubit, WeekState>(
            builder: (context, state) {
              return switch (state) {
                WeekInitial() || WeekLoading() => const WeekLoadingView(),
                WeekFailure() => const WeekFailureView(),
                WeekSuccess() => WeekView(week: state.week),
              };
            },
          );
        },
      ),
    );
  }
}
