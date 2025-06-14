import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/extensions/date_time/theme_extension.dart';
import 'package:life_calendar2/core/navigation/app_routes.dart';
import 'package:life_calendar2/ui/splash/bloc/splash_cubit.dart';
import 'package:life_calendar2/ui/splash/bloc/splash_state.dart';
import 'package:life_calendar2/ui/user/bloc/user_bloc.dart';
import 'package:life_calendar2/ui/user/bloc/user_event.dart';

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
            (context) => SplashCubit(
              databaseService: context.read(),
              userRepository: context.read(),
            )..prepareApp(),
        child: Builder(
          builder: (context) {
            return BlocListener<SplashCubit, SplashState>(
              listener: (context, state) {
                switch (state) {
                  case SplashInitial():
                  case SplashLoading():
                    break;
                  case SplashReady():
                    if (state.isAuthenticated) {
                      context.read<UserBloc>().add(UserReceived(state.user));
                      context.go(AppRoute.calendar);
                    } else {
                      context.go(AppRoute.onboarding);
                    }
                  case SplashFailure():
                    context.go(AppRoute.error);
                }
              },
              child: const SafeArea(
                child: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
