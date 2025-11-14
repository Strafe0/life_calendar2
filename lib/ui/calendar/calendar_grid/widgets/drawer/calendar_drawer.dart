import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/core/navigation/app_routes.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/calendar_drawer_footer.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/calendar_drawer_header.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/drawer_data_backup_section.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/drawer_item.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/drawer_thanks.dart';

class CalendarDrawer extends StatelessWidget {
  const CalendarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      header: const CalendarDrawerHeader(),
      footer: const CalendarDrawerFooter(),
      children: [
        const DrawerDataBackupSection(),
        DrawerItem(
          icon: Icons.feedback_outlined,
          title: context.l10n.contactDeveloper,
          onPressed:
              () => context.push('${AppRoute.calendar}/${AppRoute.feedback}'),
        ),
        const DrawerThanks(),
      ],
    );
  }
}
