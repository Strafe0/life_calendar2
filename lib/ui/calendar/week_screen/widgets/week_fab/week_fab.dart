import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';

class WeekFab extends StatelessWidget {
  const WeekFab({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).cardTheme.color;
    final foregroundColor = Theme.of(context).colorScheme.primary;

    return ExpandableFab(
      type: ExpandableFabType.up,
      distance: 65,
      openButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.add),
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
      ),
      children: [
        FloatingActionButton.extended(
          heroTag: null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          onPressed: () {},
          label: Text(context.l10n.resume),
          icon: const Icon(Icons.edit),
        ),
        FloatingActionButton.extended(
          heroTag: null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          onPressed: () {},
          label: Text(context.l10n.event),
          icon: const Icon(Icons.calendar_today),
        ),
        FloatingActionButton.extended(
          heroTag: null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          onPressed: () {},
          label: Text(context.l10n.goal),
          icon: const Icon(Icons.check),
        ),
        FloatingActionButton.extended(
          heroTag: null,
          onPressed: () {},
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          label: Text(context.l10n.photo),
          icon: const Icon(Icons.photo),
        ),
      ],
    );
  }
}
