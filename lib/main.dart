import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/data/repositories/mock/user_repository_mock.dart';
import 'package:life_calendar2/data/repositories/mock/week_repository_mock.dart';
import 'package:life_calendar2/domain/repositories/user_repository.dart';
import 'package:life_calendar2/domain/repositories/week_repository.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/core/themes/app_theme.dart';
import 'package:life_calendar2/ui/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(create: (_) => UserRepositoryMock()),
        RepositoryProvider<WeekRepository>(create: (_) => WeekRepositoryMock()),
      ],
      child: BlocProvider(
        create:
            (context) =>
                WeekCubit(weekRepository: context.read<WeekRepository>()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
