import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/navigation/app_routes.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/bloc/calendar_cubit.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_screen.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_screen.dart';
import 'package:life_calendar2/ui/feedback/feedback_screen.dart';
import 'package:life_calendar2/ui/onboarding/widgets/onboarding_screen.dart';
import 'package:life_calendar2/ui/splash/widgets/error_splash_screen.dart';
import 'package:life_calendar2/ui/splash/widgets/splash_screen.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoute.root,
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      builder:
          (context, state, child) => BlocProvider(
            create:
                (_) => CalendarCubit(
                  weekRepository: context.read(),
                  sharedPreferencesService: context.read(),
                ),
            child: child,
          ),
      routes: [
        GoRoute(
          path: AppRoute.calendar,
          builder: (context, state) => const CalendarScreen(),
          // TODO: add exit dialog
          onExit: (context, state) => false,
          routes: [
            // add shell route for week
            GoRoute(
              path: AppRoute.week,
              pageBuilder: (context, state) {
                final selectedWeekId = int.tryParse(
                  state.pathParameters['weekId'] ?? '',
                );

                if (selectedWeekId == null) {
                  return const MaterialPage(child: ErrorSplashScreen());
                }

                return CustomTransitionPage(
                  transitionsBuilder: (context, animation, _, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: BlocProvider(
                    create:
                        (context) =>
                            WeekCubit(weekRepository: context.read())
                              ..getWeek(weekId: selectedWeekId),
                    child: WeekScreen(selectedWeekId: selectedWeekId),
                  ),
                );
              },
            ),
            GoRoute(
              path: AppRoute.feedback,
              builder: (context, state) => const FeedbackScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoute.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoute.error,
      builder: (context, state) => const ErrorSplashScreen(),
    ),
  ],
);
