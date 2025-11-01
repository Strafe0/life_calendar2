import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/extensions/date_time/date_time_extension.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/user/bloc/user_bloc.dart';
import 'package:life_calendar2/ui/user/bloc/user_state.dart';

class CalendarDrawerHeader extends StatelessWidget {
  const CalendarDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final birthdateStyle = textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(context.l10n.birthdate, style: textTheme.headlineSmall),
          const SizedBox(height: 8),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserSuccess) {
                final birthdate = state.user.birthdate;

                return Text(
                  birthdate.toLocalString(context),
                  style: birthdateStyle,
                );
              }

              return Text('...', style: birthdateStyle);
            },
          ),
          const SizedBox(height: 16),
          const Divider(),
        ],
      ),
    );
  }
}
