import 'package:flutter/material.dart';
import 'package:life_calendar2/core/extensions/date_time/date_time_extension.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/domain/models/week/event/event.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: ListTile(
        title: Text(event.title, style: Theme.of(context).textTheme.bodyMedium),
        subtitle: Text(
          event.date.toLocalString(context),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        contentPadding: const EdgeInsets.only(left: 16),
        trailing: PopupMenuButton<int>(
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onSelected: (value) {
            if (value == 1) {
              // TODO: change event
            } else if (value == 2) {
              // TODO: delete event
            }
          },
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
        ),
      ),
    );
  }
}
