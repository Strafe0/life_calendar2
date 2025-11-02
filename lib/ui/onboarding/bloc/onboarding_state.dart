import 'package:equatable/equatable.dart';
import 'package:life_calendar2/domain/models/onboarding/onboarding_page.dart';

sealed class OnboardingState {
  const OnboardingState();
}

final class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

final class OnboardingLoading extends OnboardingState {
  const OnboardingLoading();
}

final class OnboardingSuccess extends OnboardingState with EquatableMixin {
  final List<OnboardingPage> pages;

  const OnboardingSuccess({required this.pages});

  @override
  List<Object?> get props => [pages];
}

final class OnboardingFailure extends OnboardingState {
  final Object exception;

  const OnboardingFailure(this.exception);
}
