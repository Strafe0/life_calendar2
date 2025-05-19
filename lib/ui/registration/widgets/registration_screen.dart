import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/core/themes/onboarding_theme.dart';
import 'package:life_calendar2/ui/registration/bloc/registration_cubit.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _birthdayTextController = TextEditingController();
  final _lifeSpanTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final onboardingTheme = OnboardingTheme(brightness: brightness);
    return BlocProvider(
      create: (context) => RegistrationCubit(authRepository: context.read()),
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: onboardingTheme.statusBarColor,
          systemNavigationBarColor: onboardingTheme.systemNavigationBarColor,
        ),
        child: SafeArea(
          child: Scaffold(
            body: DecoratedBox(
              decoration: BoxDecoration(gradient: onboardingTheme.gradient),
              child: Column(
                children: [
                  Image.asset('assets/calendar_splash_image.png'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _birthdayTextController,
                              decoration: InputDecoration(
                                labelText: context.l10n.enterBirthday,
                              ),
                              onTapOutside:
                                  (event) =>
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus(),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _lifeSpanTextController,
                              decoration: InputDecoration(
                                labelText: context.l10n.enterLifespan,
                              ),
                              onTapOutside:
                                  (event) =>
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(48),
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Text(context.l10n.ready),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
