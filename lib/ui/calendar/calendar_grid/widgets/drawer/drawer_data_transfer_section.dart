import 'package:flutter/material.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/drawer_item.dart';

class DrawerDataTransferSection extends StatelessWidget {
  const DrawerDataTransferSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerItem(
          icon: Icons.file_upload_outlined,
          title: context.l10n.calendarExport,
          // TODO: implement export
          onPressed: () {},
        ),
        DrawerItem(
          icon: Icons.file_download_outlined,
          title: context.l10n.calendarImport,
          // TODO: implement import
          onPressed: () {},
        ),
      ],
    );
  }
}
