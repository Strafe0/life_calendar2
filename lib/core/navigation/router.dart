import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/navigation/app_routes.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/bloc/calendar_cubit.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_screen.dart';
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
            GoRoute(
              path: AppRoute.week,
              builder: (context, state) {
                final selectedWeekId = int.tryParse(
                  state.pathParameters['weekId'] ?? '',
                );
                return WeekScreen(selectedWeekId: selectedWeekId);
              },
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
