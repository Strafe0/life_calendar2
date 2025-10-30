import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/bloc/calendar_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_bloc.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_event.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_failure_view.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_loading_view.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_view.dart';
import 'package:life_calendar2/ui/user/bloc/user_bloc.dart';

class WeekScreen extends StatelessWidget {
  const WeekScreen({super.key, required this.selectedWeekId});

  final int? selectedWeekId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeekAdBloc(),
      child: BlocListener<WeekCubit, WeekState>(
        listener: (context, state) {
          if (state is WeekSuccess) {
            logger.d('Update Calendar with new week');
            context.read<CalendarCubit>().updateWeek(
              week: state.week,
              brightness: MediaQuery.platformBrightnessOf(context),
            );

            _requestAdLoad(context);
          }
        },
        child: AnnotatedRegion(
          value: AppBarTheme.of(context).systemOverlayStyle!,
          child: BlocBuilder<WeekCubit, WeekState>(
            builder: (context, state) {
              return switch (state) {
                WeekSuccess() => WeekView(week: state.week),
                WeekInitial() || WeekLoading() => const WeekLoadingView(),
                WeekFailure() => const WeekFailureView(),
              };
            },
          ),
        ),
      ),
    );
  }

  void _requestAdLoad(BuildContext context) {
    final userBloc = context.read<UserBloc>();

    context.read<WeekAdBloc>().add(WeekAdLoadRequested(userAge: userBloc.age));
  }
}
