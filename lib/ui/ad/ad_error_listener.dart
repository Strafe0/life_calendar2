import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_bloc.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_state.dart';
import 'package:life_calendar2/ui/core/dialogs/alert_dialog.dart';
import 'package:life_calendar2/ui/core/dialogs/dialog_action.dart';

class AdErrorListener extends StatelessWidget {
  const AdErrorListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeekAdBloc, WeekAdState>(
      listener: (context, state) {
        switch (state) {
          case WeekAdShowFailure():
            showAlertDialog(
              context,
              title: context.l10n.error,
              content: context.l10n.errorAdLoading,
              actions: [
                DialogAction(
                  onPressed: (context) => Navigator.of(context).pop(),
                  title: context.l10n.gotIt,
                ),
              ],
            );
          default:
        }
      },
      child: child,
    );
  }
}
