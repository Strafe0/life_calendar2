import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/week/event/event.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';

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
          event.date.toString(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
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
