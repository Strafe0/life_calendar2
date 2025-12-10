import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/domain/models/user/user.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/bloc/calendar_cubit.dart';
import 'package:life_calendar2/ui/calendar/drawer/widgets/drawer_item.dart';
import 'package:life_calendar2/ui/core/dialogs/alert_dialog.dart';
import 'package:life_calendar2/ui/core/dialogs/dialog_action.dart';
import 'package:life_calendar2/ui/core/widgets/lifespan_text_field.dart';
import 'package:life_calendar2/ui/user/bloc/user_bloc.dart';
import 'package:life_calendar2/ui/user/bloc/user_event.dart';

class ChangeLifespanDrawerButton extends StatefulWidget {
  const ChangeLifespanDrawerButton({super.key});

  @override
  State<ChangeLifespanDrawerButton> createState() =>
      _ChangeLifespanDrawerButtonState();
}

class _ChangeLifespanDrawerButtonState
    extends State<ChangeLifespanDrawerButton> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final calendarCubit = context.read<CalendarCubit>();

    return DrawerItem(
      icon: Icons.watch_later_outlined,
      title: context.l10n.changeLifespan,
      onPressed: () async {
        final newLifeSpanRaw = await showDialog<String>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(context.l10n.changeLifespan),
              content: LifeSpanTextField(controller: _controller),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(null),
                  child: Text(context.l10n.cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(_controller.text),
                  child: Text(context.l10n.ready),
                ),
              ],
            );
          },
        );

        if (!context.mounted || newLifeSpanRaw == null) return;

        final newLifeSpan = int.tryParse(newLifeSpanRaw);
        if (newLifeSpan != null && User.isLifeSpanValid(newLifeSpan)) {
          final hasChangedWeeks = await calendarCubit.hasChangedWeeks(
            newLifeSpan: newLifeSpan,
          );

          if (!context.mounted) return;

          if (hasChangedWeeks) {
            final userChoice = await showAlertDialog<bool>(
              context,
              title: context.l10n.confirmChanges,
              content: context.l10n.lifespanChangeDialogMessage,
              actions: [
                DialogAction(
                  onPressed: (context) => Navigator.of(context).pop(false),
                  title: context.l10n.buttonNo,
                ),
                DialogAction(
                  onPressed: (context) => Navigator.of(context).pop(true),
                  title: context.l10n.buttonYes,
                ),
              ],
            );

            if (!(userChoice ?? false)) return;
          }

          if (context.mounted) {
            context.read<UserBloc>().add(
              UserChangeLifeSpanRequested(newLifeSpan),
            );
          }
        } else {
          await showAlertDialog(
            context,
            title: context.l10n.error,
            content: context.l10n.lifespanInterval(
              User.minLifeSpan,
              User.maxLifeSpan,
            ),
            actions: [
              DialogAction(onPressed: Navigator.pop, title: context.l10n.gotIt),
            ],
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
