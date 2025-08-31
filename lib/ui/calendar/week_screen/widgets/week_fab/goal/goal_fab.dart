import 'package:flutter/material.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_goals/goal_utils.dart';

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
      icon: const Icon(Icons.check),
    );
  }

  Future<void> _addGoal() => showGoalSheet(context);
}
