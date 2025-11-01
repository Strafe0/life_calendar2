import 'package:flutter/material.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/calendar_drawer_footer.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/calendar_drawer_header.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/drawer_data_backup_section.dart';

class CalendarDrawer extends StatelessWidget {
  const CalendarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const NavigationDrawer(
      header: CalendarDrawerHeader(),
      footer: CalendarDrawerFooter(),
      children: [DrawerDataBackupSection()],
    );
  }
}
