import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/week_fab_state_provider.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_goals/goal_change_sheet.dart';
import 'package:life_calendar2/ui/core/widgets/bottom_sheet.dart';

class GoalWidget extends StatelessWidget {
  const GoalWidget({super.key, required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: CheckboxListTile(
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
        secondary: PopupMenuButton<int>(
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    context.l10n.edit,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    context.l10n.delete,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
          onSelected: (value) {
            if (value == 1) {
              _changeGoal(context);
            } else if (value == 2) {
              // TODO: delete goal
            }
          },
        ),
      ),
    );
  }

  Future<void> _changeGoal(BuildContext context) async {
    final weekCubit = context.read<WeekCubit>();
    final fabState = WeekFabStateProvider.of(context);

    await showDraggableBottomSheet(
      context,
      title: context.l10n.goalEdit,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GoalChangeSheet(
            initialText: goal.title,
            onSubmit: (title) async {
              await weekCubit.changeGoal(goal.copyWith(title: title));
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
