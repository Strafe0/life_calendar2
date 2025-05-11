import 'package:go_router/go_router.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_screen.dart';
import 'package:life_calendar2/ui/home/home_screen.dart';
import 'package:life_calendar2/ui/onboarding/widgets/onboarding_screen.dart';
import 'package:life_calendar2/ui/splash/widgets/error_splash_screen.dart';
import 'package:life_calendar2/ui/splash/widgets/splash_screen.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/calendar',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: '/week/:weekId',
          builder: (context, state) {
            final selectedWeekId = int.tryParse(
              state.pathParameters['weekId'] ?? '',
            );
            return WeekScreen(selectedWeekId: selectedWeekId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/error',
      builder: (context, state) => const ErrorSplashScreen(),
    ),
  ],
);
