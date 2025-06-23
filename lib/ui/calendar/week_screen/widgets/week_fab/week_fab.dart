import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/resume/resume_fab.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/week_fab_state_provider.dart';

class WeekFab extends StatefulWidget {
  const WeekFab({super.key});

  @override
  State<WeekFab> createState() => _WeekFabState();
}

class _WeekFabState extends State<WeekFab> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).cardTheme.color;
    final foregroundColor = Theme.of(context).colorScheme.primary;

    return ExpandableFab(
      key: WeekFabStateProvider.of(context).fabKey,
      type: ExpandableFabType.up,
      distance: 65,
      openButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.add),
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
      ),
      children: [
        const ResumeFab(),
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
