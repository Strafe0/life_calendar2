import 'package:flutter/material.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/backup/export_dialog.dart';
import 'package:life_calendar2/ui/backup/import_dialog.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/drawer_item.dart';

class DrawerDataBackupSection extends StatelessWidget {
  const DrawerDataBackupSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerItem(
          icon: Icons.file_upload_outlined,
          title: context.l10n.calendarExport,
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => const ExportDialog(),
            );
          },
        ),
        DrawerItem(
          icon: Icons.file_download_outlined,
          title: context.l10n.calendarImport,
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => const ImportDialog(),
            );
          },
        ),
      ],
    );
  }
}
