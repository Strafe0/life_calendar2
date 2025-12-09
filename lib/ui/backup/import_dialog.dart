import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/core/logger/logger.dart';
import 'package:life_calendar2/domain/services/local_backup_service.dart';
import 'package:life_calendar2/ui/core/snackbars/error_snack_bar.dart';
import 'package:life_calendar2/utils/result.dart';

class ImportDialog extends StatelessWidget {
  const ImportDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.importDialogTitle),
      content: Text(context.l10n.importDrawerDialogMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.cancel),
        ),
        TextButton(
          onPressed: () async {
            final result =
                await context.read<LocalBackupService>().importCalendar();

            if (result is Ok<bool> && result.value) {
              exit(0);
            }

            if (!context.mounted) {
              logger.w('Context is not mounted');
              return;
            }

            if (result is Ok<bool>) {
              Navigator.pop(context);
            } else {
              showErrorSnackBar(context, text: context.l10n.errorImport);
            }
          },
          child: Text(context.l10n.continueButton),
        ),
      ],
    );
  }
}
