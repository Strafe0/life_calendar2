import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_events/event_change_sheet.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/week_fab_state_provider.dart';
import 'package:life_calendar2/ui/core/widgets/bottom_sheet.dart';

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

  Future<void> _addEvent() async {
    final weekCubit = context.read<WeekCubit>();
    final fabState = WeekFabStateProvider.of(context);

    final weekState = weekCubit.state as WeekSuccess;
    final startDate = weekState.week.start;
    final endDate = weekState.week.end;

    await showDraggableBottomSheet(
      context,
      title: context.l10n.event,
      builder: (context) {
        logger.d('Build event sheet');
        return Padding(
          padding: const EdgeInsets.all(16),
          child: EventChangeSheet(
            firstDate: startDate,
            lastDate: endDate,
            onSubmit: (date, title) async {
              // TODO: not working
              logger.d('add event');
              await weekCubit.addEvent(date, title);
              logger.d('added event');
              if (context.mounted) {
                logger.d('Pop event sheet');
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
