import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_calendar/core/extensions/brightness_extension.dart';
import 'package:life_calendar/ui/calendar/calendar_grid/widgets/calendar_view.dart';
import 'package:life_calendar/ui/calendar/drawer/widgets/calendar_drawer.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: ColorScheme.of(context).surface,
        statusBarIconBrightness:
            Theme.brightnessOf(context).isDarkMode
                ? Brightness.light
                : Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          drawer: const CalendarDrawer(),
          drawerEdgeDragWidth: 40,
          body: LayoutBuilder(
            builder: (_, constraints) => CalendarView(constraints: constraints),
          ),
        ),
      ),
    );
  }
}
