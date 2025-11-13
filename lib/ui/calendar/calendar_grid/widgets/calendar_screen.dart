import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_calendar2/core/extensions/theme_extension.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_view.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/calendar_drawer.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = theme.colorScheme.surface;
    final isDarkMode = theme.isDarkMode;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: surfaceColor,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
      child: const SafeArea(
        child: Scaffold(
          drawer: CalendarDrawer(),
          drawerEdgeDragWidth: 40,
          body: CalendarView(),
        ),
      ),
    );
  }
}
