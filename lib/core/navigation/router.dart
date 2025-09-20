import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/navigation/app_routes.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/bloc/calendar_cubit.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_screen.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/photo_view/photo_viewer.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_screen.dart';
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
          routes: [
            // add shell route for week
            GoRoute(
              path: AppRoute.week,
              pageBuilder: (context, state) {
                final selectedWeekId = int.tryParse(
                  state.pathParameters['weekId'] ?? '',
                );

                return CustomTransitionPage(
                  transitionsBuilder: (context, animation, _, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child:
                      selectedWeekId != null
                          ? WeekScreen(selectedWeekId: selectedWeekId)
                          : const ErrorSplashScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: AppRoute.photoView,
                  builder: (context, state) {
                    final weekCubit = context.read<WeekCubit>();

                    final photoIndex = int.tryParse(
                      state.pathParameters['index'] ?? '',
                    );

                    return photoIndex != null
                        ? BlocProvider<WeekCubit>.value( // NOT WORKING
                          value: weekCubit,
                          child: PhotoViewer(initialIndex: photoIndex),
                        )
                        : const ErrorSplashScreen();
                  },
                ),
              ],
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
