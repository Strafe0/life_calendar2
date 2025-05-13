import 'package:life_calendar2/domain/models/onboarding/onboarding_page.dart';
import 'package:life_calendar2/utils/result.dart';

abstract class OnboardingRepository {
  Future<Result<List<OnboardingPage>>> getPages();
}