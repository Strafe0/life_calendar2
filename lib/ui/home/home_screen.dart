import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/calendar_view.dart';
import 'package:life_calendar2/ui/user/bloc/user_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InteractiveViewer(
          maxScale: 5,
          child: BlocProvider<UserCubit>(
            create:
                (context) =>
                    UserCubit(userRepository: context.read())..getUser(),
            child: const CalendarView(),
          ),
        ),
      ),
    );
  }
}
