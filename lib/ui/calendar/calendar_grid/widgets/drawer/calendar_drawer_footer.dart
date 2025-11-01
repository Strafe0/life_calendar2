import 'package:flutter/material.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/drawer_item.dart';

class CalendarDrawerFooter extends StatelessWidget {
  const CalendarDrawerFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Divider(indent: 16, endIndent: 16),
          DrawerItem(
            icon: Icons.shield_outlined,
            title: context.l10n.privacyPolicy,
            // TODO: implement privacy policy
            onPressed: () {},
          ),
          const SizedBox(height: 54),
        ],
      ),
    );
  }
}
