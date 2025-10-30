import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/week_fab_state_provider.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_resume/resume_text_field.dart';
import 'package:life_calendar2/ui/core/widgets/bottom_sheet.dart';

Future<void> showResumeSheet(BuildContext context) async {
  final weekCubit = context.read<WeekCubit>();
  final fabState = WeekFabStateProvider.of(context);

  String initialText = '';
  final weekState = weekCubit.state;
  if (weekState is WeekSuccess) {
    initialText = weekState.week.resume;
  }

  await showDraggableBottomSheet(
    context,
    title: context.l10n.resume,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: ResumeTextField(
          initialText: initialText,
          onEditingComplete: (newResumeText) async {
            await weekCubit.changeResume(newResumeText);
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
