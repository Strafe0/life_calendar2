import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/core/logger/logger.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_goals/goal_utils.dart';
import 'package:life_calendar2/ui/core/constants.dart';
import 'package:life_calendar2/ui/core/menus/adaptive_action_menu.dart';

class GoalWidget extends StatelessWidget {
  const GoalWidget({super.key, required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shapeBorder,
      child: CheckboxListTile.adaptive(
        checkboxScaleFactor: Platform.isIOS ? 1.3 : 1,
        shape: shapeBorder,
        controlAffinity: ListTileControlAffinity.leading,
        value: goal.isCompleted,
        onChanged: (newValue) {
          if (newValue != null) {
            context.read<WeekCubit>().toggleGoal(
              goalId: goal.id,
              isCompleted: newValue,
            );
          } else {
            logger.w('New goal.isCompleted is null');
          }
        },
        title: Text(goal.title, style: Theme.of(context).textTheme.bodyMedium),
        contentPadding: const EdgeInsets.only(left: 8),
        secondary: AdaptiveActionMenu(
          onEdit: () => showGoalSheet(context, goal: goal),
          onDelete: () => context.read<WeekCubit>().deleteGoal(goal),
          editLabel: context.l10n.edit,
          deleteLabel: context.l10n.delete,
          cancelLabel: context.l10n.cancel,
        ),
      ),
    );
  }
}
