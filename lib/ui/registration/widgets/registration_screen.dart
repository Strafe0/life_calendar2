import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/navigation/app_routes.dart';
import 'package:life_calendar2/ui/registration/bloc/registration_cubit.dart';
import 'package:life_calendar2/ui/registration/bloc/registration_state.dart';
import 'package:life_calendar2/ui/registration/widgets/registration_form_body.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => RegistrationCubit(
            authRepository: context.read(),
            weekRepository: context.read(),
          ),
      child: Builder(
        builder: (context) {
          return BlocListener<RegistrationCubit, RegistrationState>(
            listener: (context, state) {
              switch (state) {
                case RegistrationSuccess():
                  context.go(AppRoute.calendar);
                case RegistrationFailure():
                  // TODO: add snackbar
                  break;
                default:
                  break;
              }
            },
            child: Column(
              children: [
                Image.asset('assets/calendar_splash_image.png'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: RegistrationFormBody(formKey: _formKey),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
