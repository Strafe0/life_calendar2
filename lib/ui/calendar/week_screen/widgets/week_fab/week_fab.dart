import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:life_calendar/ui/calendar/week_screen/widgets/week_fab/event/event_fab.dart';
import 'package:life_calendar/ui/calendar/week_screen/widgets/week_fab/goal/goal_fab.dart';
import 'package:life_calendar/ui/calendar/week_screen/widgets/week_fab/photo/photo_fab.dart';
import 'package:life_calendar/ui/calendar/week_screen/widgets/week_fab/resume/resume_fab.dart';
import 'package:life_calendar/ui/calendar/week_screen/widgets/week_fab/week_fab_state_provider.dart';

class WeekFab extends StatefulWidget {
  const WeekFab({super.key});

  @override
  State<WeekFab> createState() => _WeekFabState();
}

class _WeekFabState extends State<WeekFab> {
  @override
  Widget build(BuildContext context) {
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
      children: const [ResumeFab(), EventFab(), GoalFab(), PhotoFab()],
    );
  }
}
