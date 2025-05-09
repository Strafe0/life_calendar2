import 'package:go_router/go_router.dart';
import 'package:life_calendar2/splash_screen.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_screen.dart';
import 'package:life_calendar2/ui/home/home_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/calendar',
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
  ],
);
