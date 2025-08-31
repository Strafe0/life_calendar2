import 'package:flutter/material.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_events/event_utils.dart';

class EventFab extends StatefulWidget {
  const EventFab({super.key});

  @override
  State<EventFab> createState() => _EventFabState();
}

class _EventFabState extends State<EventFab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      backgroundColor: Theme.of(context).cardTheme.color,
      foregroundColor: Theme.of(context).colorScheme.primary,
      onPressed: _addEvent,
      label: Text(context.l10n.event),
      icon: const Icon(Icons.calendar_today),
    );
  }

  Future<void> _addEvent() => showEventSheet(context);
}
