import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/navigation/router.dart';
import 'package:life_calendar2/data/repositories/auth_repository/auth_repository.dart';
import 'package:life_calendar2/data/repositories/auth_repository/auth_repository_impl.dart';
import 'package:life_calendar2/data/repositories/onboarding_repository/onboarding_repository.dart';
import 'package:life_calendar2/data/repositories/onboarding_repository/onboarding_repository_impl.dart';
import 'package:life_calendar2/data/repositories/user_repository/user_repository.dart';
import 'package:life_calendar2/data/repositories/user_repository/user_repository_mock.dart';
import 'package:life_calendar2/data/repositories/week_repository/week_repository.dart';
import 'package:life_calendar2/data/repositories/week_repository/week_repository_mock.dart';
import 'package:life_calendar2/data/services/shared_preferences_service.dart';
import 'package:life_calendar2/l10n/app_localizations.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/core/themes/app_theme.dart';

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => const SharedPreferencesService(),
        ),
        RepositoryProvider<OnboardingRepository>(
          create: (context) => const OnboardingRepositoryImpl(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) {
            return AuthRepositoryImpl(sharedPreferencesService: context.read());
          },
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepositoryMock(),
        ),
        RepositoryProvider<WeekRepository>(
          create: (context) => WeekRepositoryMock(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Life Calendar',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: goRouter,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, widget) {
          Widget error = Center(child: Text(context.l10n.errorHappened));
          if (widget is Scaffold || widget is Navigator) {
            error = Scaffold(body: error);
          }
          ErrorWidget.builder = (errorDetails) => error;
          if (widget != null) return widget;
          throw StateError('Widget is null');
        },
      ),
    );
  }
}
