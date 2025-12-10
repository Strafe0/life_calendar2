import 'package:life_calendar/domain/models/onboarding/onboarding_page.dart';
import 'package:life_calendar/utils/result.dart';

abstract class OnboardingRepository {
  Future<Result<List<OnboardingPage>>> getPages({bool isFullOnboarding = true});
}
