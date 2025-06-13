import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/extensions/date_time/theme_extension.dart';
import 'package:life_calendar2/core/navigation/app_routes.dart';
import 'package:life_calendar2/ui/user/bloc/user_cubit.dart';
import 'package:life_calendar2/ui/user/bloc/user_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = theme.colorScheme.surface;
    final isDarkMode = theme.isDarkMode;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: surfaceColor,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
      child: BlocProvider(
        create:
            (context) => UserCubit(userRepository: context.read())..getUser(),
        child: Builder(
          builder: (context) {
            return BlocListener<UserCubit, UserState>(
              listener: (context, state) {
                if (state is UserSuccess) {
                  if (!state.user.isEmpty) {
                    context.go(AppRoute.calendar);
                  } else {
                    context.go(AppRoute.onboarding);
                  }
                } else if (state is UserFailure) {
                  context.go(AppRoute.error);
                }
              },
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: surfaceColor,
                  body: const Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
