import 'package:flutter/material.dart';
import 'package:life_calendar/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar/ui/calendar/week_screen/widgets/week_events/event_utils.dart';

class EventFab extends StatelessWidget {
  const EventFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      backgroundColor: Theme.of(context).cardTheme.color,
      foregroundColor: Theme.of(context).colorScheme.primary,
      onPressed: () => showEventSheet(context),
      label: Text(context.l10n.event),
      icon: const Icon(Icons.calendar_today),
    );
  }
}
