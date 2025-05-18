class AppRoute {
  static const root = '/';
  static const calendar = '/calendar';
  static const week = '/week/:weekId';
  static String weekId(int weekId) => '/week/$weekId';

  static const onboarding = '/onboarding';
  static const registration = '/registration';

  static const error = '/error';
}
