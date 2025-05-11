import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/ui/user/bloc/user_cubit.dart';
import 'package:life_calendar2/ui/user/bloc/user_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: surfaceColor,
        systemNavigationBarColor: surfaceColor,
      ),
      child: BlocProvider(
        create:
            (context) => UserCubit(userRepository: context.read())..getUser(),
        child: Builder(
          builder: (context) {
            return BlocListener<UserCubit, UserState>(
              listener: (context, state) {
                if (state is UserSuccess) {
                  if (!state.user.isEmpty) {
                    context.go('/calendar');
                  } else {
                    context.go('/onboarding');
                  }
                } else if (state is UserFailure) {
                  context.go('/error');
                }
              },
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: surfaceColor,
                  body: const Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
