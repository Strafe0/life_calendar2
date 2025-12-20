import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar/core/extensions/date_time/date_time_extension.dart';
import 'package:life_calendar/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar/domain/models/week/event/event.dart';
import 'package:life_calendar/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar/ui/calendar/week_screen/widgets/week_events/event_utils.dart';
import 'package:life_calendar/ui/core/constants.dart';
import 'package:life_calendar/ui/core/menus/adaptive_action_menu.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shapeBorder,
      child: ListTile(
        title: Text(event.title, style: Theme.of(context).textTheme.bodyMedium),
        subtitle: Text(
          event.date.toLocalString(context),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        contentPadding: const EdgeInsets.only(left: 16),
        trailing: AdaptiveActionMenu(
          onEdit: () => showEventSheet(context, event: event),
          onDelete: () => context.read<WeekCubit>().deleteEvent(event),
          editLabel: context.l10n.edit,
          deleteLabel: context.l10n.delete,
          cancelLabel: context.l10n.cancel,
        ),
      ),
    );
  }
}
