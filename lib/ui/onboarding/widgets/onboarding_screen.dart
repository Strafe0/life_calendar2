import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/ui/core/themes/onboarding_theme.dart';
import 'package:life_calendar2/ui/onboarding/bloc/onboarding_cubit.dart';
import 'package:life_calendar2/ui/onboarding/bloc/onboarding_state.dart';
import 'package:life_calendar2/ui/onboarding/widgets/onboarding_error_view.dart';
import 'package:life_calendar2/ui/onboarding/widgets/onboarding_loading_view.dart';
import 'package:life_calendar2/ui/onboarding/widgets/onboarding_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final theme = OnboardingTheme(brightness: brightness);

    return BlocProvider(
      create:
          (context) =>
              OnboardingCubit(onboardingRepository: context.read())
                ..loadPages(),
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: theme.statusBarColor,
          systemNavigationBarColor: theme.systemNavigationBarColor,
          statusBarBrightness:
              brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
        ),
        child: SafeArea(
          maintainBottomViewPadding: true,
          child: Scaffold(
            body: DecoratedBox(
              decoration: BoxDecoration(gradient: theme.gradient),
              child: BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  return switch (state) {
                    OnboardingInitial() ||
                    OnboardingLoading() => const OnboardingLoadingView(),
                    OnboardingFailure() => const OnboardingErrorView(),
                    OnboardingSuccess() => OnboardingView(pages: state.pages),
                  };
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
