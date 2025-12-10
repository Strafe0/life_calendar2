class AppRoute {
  static const root = '/';

  static const calendar = '/calendar';
  static const week = 'week/:weekId';
  static String weekId(int weekId) => '$calendar/week/$weekId';

  static const photoView = 'photo-view/:index';

  static const feedback = 'feedback';

  static const onboarding = '/onboarding/:isFull';
  static String onboardingPath({required bool isFull}) => '/onboarding/$isFull';

  static const error = '/error';
}
