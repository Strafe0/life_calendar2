import 'package:life_calendar2/domain/models/user/user.dart';

sealed class RegistrationState {
  const RegistrationState();
}

final class RegistrationInitial extends RegistrationState {
  const RegistrationInitial();
}

final class RegistrationLoading extends RegistrationState {
  const RegistrationLoading();
}

final class RegistrationSuccess extends RegistrationState {
  final User user;

  const RegistrationSuccess(this.user);
}

final class RegistrationFailure extends RegistrationState {
  const RegistrationFailure();
}

final class RegistrationCalendarFailure extends RegistrationState {
  const RegistrationCalendarFailure();
}
