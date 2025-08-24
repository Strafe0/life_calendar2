import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/event/event_fab.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/goal/goal_fab.dart';
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
        const EventFab(),
        const GoalFab(),
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
