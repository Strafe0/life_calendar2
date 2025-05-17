import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/repositories/onboarding_repository/onboarding_repository.dart';
import 'package:life_calendar2/domain/models/onboarding/onboarding_page.dart';
import 'package:life_calendar2/ui/onboarding/bloc/onboarding_state.dart';
import 'package:life_calendar2/utils/result.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository _onboardingRepository;

  OnboardingCubit({required OnboardingRepository onboardingRepository})
    : _onboardingRepository = onboardingRepository,
      super(const OnboardingInitial());

  Future<void> loadPages() async {
    if (state is OnboardingLoading) return;

    emit(const OnboardingLoading());

    final pagesResult = await _onboardingRepository.getPages();

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
