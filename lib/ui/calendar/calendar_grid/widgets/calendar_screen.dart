import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_calendar/ui/calendar/calendar_grid/widgets/calendar_view.dart';
import 'package:life_calendar/ui/calendar/drawer/widgets/calendar_drawer.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: ColorScheme.of(context).surface,
        statusBarBrightness: Theme.brightnessOf(context),
      ),
      child: Scaffold(
        drawer: const CalendarDrawer(),
        drawerEdgeDragWidth: 40,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (_, constraints) => CalendarView(constraints: constraints),
          ),
        ),
      ),
    );
  }
}
