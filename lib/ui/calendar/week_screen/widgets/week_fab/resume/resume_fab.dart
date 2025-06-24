import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/week_fab_state_provider.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_resume/resume_text_field.dart';
import 'package:life_calendar2/ui/core/widgets/bottom_sheet.dart';

class ResumeFab extends StatefulWidget {
  const ResumeFab({super.key});

  @override
  State<ResumeFab> createState() => _ResumeFabState();
}

class _ResumeFabState extends State<ResumeFab> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    final weekState = context.read<WeekCubit>().state;
    if (weekState is WeekSuccess) {
      _textController = TextEditingController(text: weekState.week.resume);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      backgroundColor: Theme.of(context).cardTheme.color,
      foregroundColor: Theme.of(context).colorScheme.primary,
      onPressed: _addResume,
      label: Text(context.l10n.resume),
      icon: const Icon(Icons.edit),
    );
  }

  Future<void> _addResume() async {
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

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
