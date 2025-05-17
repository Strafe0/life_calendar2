import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/navigation/router.dart';
import 'package:life_calendar2/data/repositories/mock/user_repository_mock.dart';
import 'package:life_calendar2/data/repositories/mock/week_repository_mock.dart';
import 'package:life_calendar2/data/repositories/onboarding_repository_local.dart';
import 'package:life_calendar2/domain/repositories/onboarding_repository.dart';
import 'package:life_calendar2/domain/repositories/user_repository.dart';
import 'package:life_calendar2/domain/repositories/week_repository.dart';
import 'package:life_calendar2/l10n/app_localizations.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/core/themes/app_theme.dart';

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OnboardingRepository>(
          create: (_) => const OnboardingRepositoryLocal(),
        ),
        RepositoryProvider<UserRepository>(create: (_) => UserRepositoryMock()),
        RepositoryProvider<WeekRepository>(create: (_) => WeekRepositoryMock()),
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
