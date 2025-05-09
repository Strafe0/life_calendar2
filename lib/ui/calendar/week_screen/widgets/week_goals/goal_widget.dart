import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';

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
                    'Изменить',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    'Удалить',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
          onSelected: (value) async {
            if (value == 1) {
              // TODO: change goal title
            } else if (value == 2) {
              // TODO: delete goal
            }
          },
        ),
      ),
    );
  }
}
