import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/core/navigation/app_routes.dart';
import 'package:life_calendar/domain/services/local_backup_service.dart';
import 'package:life_calendar/ui/core/snackbars/error_snack_bar.dart';
import 'package:life_calendar/utils/result.dart';

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
            final navigator = Navigator.of(context);
            final router = GoRouter.of(context);

            final result = await context
                .read<LocalBackupService>()
                .importCalendar();

            if (result is Ok<bool> && result.value) {
              // Re-run the splash initialization against the freshly restored
              // database/preferences instead of force-quitting the process.
              // The shell route owning CalendarCubit is torn down and rebuilt,
              // so all in-memory state is reloaded from the imported data.
              navigator.pop();
              router.go(AppRoute.root);
              return;
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
