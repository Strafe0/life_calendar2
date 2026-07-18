import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar/domain/services/local_backup_service.dart';
import 'package:life_calendar/ui/core/snackbars/error_snack_bar.dart';
import 'package:life_calendar/ui/user/bloc/user_bloc.dart';
import 'package:life_calendar/ui/user/bloc/user_event.dart';
import 'package:life_calendar/utils/result.dart';

class ImportDialog extends StatefulWidget {
  const ImportDialog({super.key});

  @override
  State<ImportDialog> createState() => _ImportDialogState();
}

class _ImportDialogState extends State<ImportDialog> {
  bool _isImporting = false;

  Future<void> _import() async {
    if (_isImporting) {
      return;
    }
    setState(() => _isImporting = true);

    final result = await context.read<LocalBackupService>().importCalendar();

    if (!mounted) {
      return;
    }

    if (result is Ok<bool> && result.value) {
      // Reload the user in place: CalendarView listens to UserBloc and rebuilds
      // the grid from the freshly imported database/preferences. Staying on the
      // calendar route avoids the route teardown (and its exit-confirmation and
      // cubit lifecycle issues) that navigating through splash caused.
      context.read<UserBloc>().add(const UserLoadingTriggered());
      Navigator.pop(context);
      return;
    }

    // Either the user cancelled the file picker (Ok(false)) or the import
    // failed (ResultError). Re-enable the dialog so it can be retried/dismissed.
    setState(() => _isImporting = false);

    if (result is! Ok<bool>) {
      showErrorSnackBar(context, text: context.l10n.errorImport);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isImporting,
      child: AlertDialog(
        title: Text(context.l10n.importDialogTitle),
        content: _isImporting
            ? const SizedBox(
                height: 64,
                child: Center(child: CircularProgressIndicator()),
              )
            : Text(context.l10n.importDrawerDialogMessage),
        actions: _isImporting
            ? null
            : [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.l10n.cancel),
                ),
                TextButton(
                  onPressed: _import,
                  child: Text(context.l10n.continueButton),
                ),
              ],
      ),
    );
  }
}
