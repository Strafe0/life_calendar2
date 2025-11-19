import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/domain/models/user/user.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/drawer/drawer_item.dart';
import 'package:life_calendar2/ui/core/dialogs/alert_dialog.dart';
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
    // TODO: add l10n and change icon
    return DrawerItem(
      icon: Icons.change_history,
      title: 'Change lifeSpan',
      onPressed: () async {
        final newLifeSpanRaw = await showDialog<String>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Change lifeSpan'),
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

        if (!context.mounted) return;

        final newLifeSpan = int.tryParse(newLifeSpanRaw ?? '');
        if (newLifeSpan != null && User.isLifeSpanValid(newLifeSpan)) {
          context.read<UserBloc>().add(
            UserChangeLifeSpanRequested(newLifeSpan),
          );
        } else {
          await showAlertDialog(
            context,
            title: context.l10n.error,
            content: context.l10n.errorHappened,
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
