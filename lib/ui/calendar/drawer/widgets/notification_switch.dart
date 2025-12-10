import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/drawer/bloc/settings_cubit.dart';

class NotificationSwitch extends StatefulWidget {
  const NotificationSwitch({super.key});

  @override
  State<NotificationSwitch> createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsCubit>().loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SwitchListTile.adaptive(
          secondary: const Icon(Icons.event_repeat),
          title: Text(context.l10n.notificationSwitchTitle),
          value: state.isWeeklyReminderEnabled,
          onChanged: (value) {
            context.read<SettingsCubit>().toggleReminder(value);
          },
        );
      },
    );
  }
}
