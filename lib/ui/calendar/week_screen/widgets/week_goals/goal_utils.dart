import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/week_fab_state_provider.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_goals/goal_change_sheet.dart';
import 'package:life_calendar2/ui/core/widgets/bottom_sheet.dart';

Future<void> showGoalSheet(BuildContext context, {Goal? goal}) async {
  final weekCubit = context.read<WeekCubit>();
  final fabState = WeekFabStateProvider.of(context);

  final isCreation = goal == null;

  await showDraggableBottomSheet(
    context,
    title: isCreation ? context.l10n.goalCreation : context.l10n.goalEdit,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: GoalChangeSheet(
          initialText: goal?.title,
          onSubmit: (title) async {
            if (isCreation) {
              await weekCubit.addGoal(title);
            } else {
              await weekCubit.changeGoal(goal.copyWith(title: title));
            }

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
