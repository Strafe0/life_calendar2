import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/extensions/date_time/theme_extension.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_view.dart';
import 'package:life_calendar2/ui/user/bloc/user_cubit.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = theme.colorScheme.surface;
    final isDarkMode = theme.isDarkMode;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: surfaceColor,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          body: InteractiveViewer(
            maxScale: 5,
            child: BlocProvider<UserCubit>(
              create:
                  (context) =>
                      UserCubit(userRepository: context.read())..getUser(),
              child: const CalendarView(),
            ),
          ),
        ),
      ),
    );
  }
}
