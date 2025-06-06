import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_goals/goal_widget.dart';

class WeekGoalListWidget extends StatelessWidget {
  const WeekGoalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(left: 12, bottom: 4),
          sliver: SliverToBoxAdapter(
            child: Text(
              context.l10n.goals,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        BlocBuilder<WeekCubit, WeekState>(
          builder: (context, state) {
            final goals = state is WeekSuccess ? state.week.goals : [];

            if (goals.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(child: Text(context.l10n.noGoals)),
              );
            }

            return SliverList.builder(
              itemCount: goals.length,
              itemBuilder: (_, index) => GoalWidget(goal: goals[index]),
            );
          },
        ),
      ],
    );
  }
}
