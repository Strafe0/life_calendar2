class AppRoute {
  static const root = '/';

  static const calendar = '/calendar';
  static const week = 'week/:weekId';
  static String weekId(int weekId) => '$calendar/week/$weekId';

  static const photoView = 'photo-view/:index';

  static const onboarding = '/onboarding';

  static const error = '/error';
}
