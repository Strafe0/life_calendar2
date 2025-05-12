import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/navigation/router.dart';
import 'package:life_calendar2/data/repositories/mock/user_repository_mock.dart';
import 'package:life_calendar2/data/repositories/mock/week_repository_mock.dart';
import 'package:life_calendar2/domain/repositories/user_repository.dart';
import 'package:life_calendar2/domain/repositories/week_repository.dart';
import 'package:life_calendar2/ui/core/themes/app_theme.dart';

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(create: (_) => UserRepositoryMock()),
        RepositoryProvider<WeekRepository>(create: (_) => WeekRepositoryMock()),
      ],
      child: MaterialApp.router(
        title: 'Календарь жизни',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: goRouter,
        builder: (context, widget) {
          Widget error = const Text('Ошибка приложения');
          if (widget is Scaffold || widget is Navigator) {
            error = Scaffold(body: Center(child: error));
          }
          ErrorWidget.builder = (errorDetails) => error;
          if (widget != null) return widget;
          throw StateError('Widget is null');
        },
      ),
    );
  }
}
