import 'package:life_calendar2/data/repositories/onboarding_repository/onboarding_repository.dart';
import 'package:life_calendar2/domain/models/onboarding/onboarding_page.dart';
import 'package:life_calendar2/utils/result.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl();

  @override
  Future<Result<List<OnboardingPage>>> getPages() {
    return Future.value(
      Result.ok([
        OnboardingPage(
          image: 'assets/onboarding/life_calendar_paper.png',
          titleResolver: (l10n) => l10n.onboardingTitleWelcome,
          contentResolver: (l10n) => l10n.onboardingContentWelcome,
        ),
        OnboardingPage(
          image: 'assets/onboarding/life_calendar_arrows.png',
          titleResolver: (l10n) => l10n.onboardingTitleGrid,
          contentResolver: (l10n) => l10n.onboardingContentGrid,
        ),
        OnboardingPage(
          image: 'assets/onboarding/zoom_select.png',
          titleResolver: (l10n) => l10n.onboardingTitleZoom,
          contentResolver: (l10n) => l10n.onboardingContentZoom,
        ),
        OnboardingPage(
          image: 'assets/onboarding/current_week_button.png',
          titleResolver: (l10n) => l10n.onboardingTitleJumpToCurrentWeek,
          contentResolver: (l10n) => l10n.onboardingContentJumpToCurrentWeek,
        ),
      ]),
    );
  }
}
