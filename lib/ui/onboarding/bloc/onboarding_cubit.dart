import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/data/repositories/onboarding_repository/onboarding_repository.dart';
import 'package:life_calendar/domain/models/onboarding/onboarding_page.dart';
import 'package:life_calendar/ui/onboarding/bloc/onboarding_state.dart';
import 'package:life_calendar/utils/result.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository _onboardingRepository;

  OnboardingCubit({required OnboardingRepository onboardingRepository})
    : _onboardingRepository = onboardingRepository,
      super(const OnboardingInitial());

  Future<void> loadPages({required bool isFullOnboarding}) async {
    if (state is OnboardingLoading) return;

    emit(const OnboardingLoading());

    final pagesResult = await _onboardingRepository.getPages(
      isFullOnboarding: isFullOnboarding,
    );

    switch (pagesResult) {
      case Ok<List<OnboardingPage>>():
        logger.d('Successfully loaded onboarding pages');
        emit(OnboardingSuccess(pages: pagesResult.value));
      case Error<List<OnboardingPage>>():
        logger.e('Failed to get onboarding pages');
        emit(OnboardingFailure(pagesResult.error));
    }
  }
}
