import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/data/repositories/mock/week_repository_mock.dart';
import 'package:life_calendar2/domain/repositories/week_repository.dart';
import 'package:life_calendar2/ui/calendar/widgets/calendar_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<WeekRepository>(
      create: (context) => WeekRepositoryMock(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Календарь жизни')),
          body: const CalendarView(),
        ),
      ),
    );
  }
}
