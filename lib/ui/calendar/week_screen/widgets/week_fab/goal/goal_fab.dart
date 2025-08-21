import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/week_fab_state_provider.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_goals/goal_change_sheet.dart';
import 'package:life_calendar2/ui/core/widgets/bottom_sheet.dart';

class GoalFab extends StatefulWidget {
  const GoalFab({super.key});

  @override
  State<GoalFab> createState() => _GoalFabState();
}

class _GoalFabState extends State<GoalFab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      backgroundColor: Theme.of(context).cardTheme.color,
      foregroundColor: Theme.of(context).colorScheme.primary,
      onPressed: _addGoal,
      label: Text(context.l10n.goal),
      icon: const Icon(Icons.calendar_today),
    );
  }

  Future<void> _addGoal() async {
    final weekCubit = context.read<WeekCubit>();
    final fabState = WeekFabStateProvider.of(context);

    await showDraggableBottomSheet(
      context,
      title: context.l10n.event,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GoalChangeSheet(
            onSubmit: (title) async {
              await weekCubit.addGoal(title);
              if (context.mounted) {
                context.pop();
              }
            },
          ),
        );
      },
    );

    fabState.close();
  }
}
