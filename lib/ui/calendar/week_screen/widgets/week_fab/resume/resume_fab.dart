import 'package:flutter/material.dart';
import 'package:life_calendar/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar/ui/calendar/week_screen/widgets/week_resume/resume_utils.dart';

class ResumeFab extends StatelessWidget {
  const ResumeFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      backgroundColor: Theme.of(context).cardTheme.color,
      foregroundColor: Theme.of(context).colorScheme.primary,
      onPressed: () => showResumeSheet(context),
      label: Text(context.l10n.resume),
      icon: const Icon(Icons.edit),
    );
  }
}
