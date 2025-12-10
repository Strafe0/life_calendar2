import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar/core/extensions/connection_state_extension.dart';
import 'package:life_calendar/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar/domain/services/local_backup_service.dart';

class ExportDialog extends StatefulWidget {
  const ExportDialog({super.key});

  @override
  State<ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<ExportDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.exportDialogTitle),
      content: FutureBuilder<bool>(
        future: context.read<LocalBackupService>().exportCalendar(),
        builder: (context, snapshot) {
          if (snapshot.connectionState.isLoading) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: CircularProgressIndicator(),
                ),
                Text(context.l10n.archiveCreationInProcess),
              ],
            );
          }

          final success = snapshot.data ?? false;
          if (success) {
            return Text(context.l10n.archiveCreationSuccess);
          }

          return Text(context.l10n.errorArchiveCreation);
        },
      ),
    );
  }
}
