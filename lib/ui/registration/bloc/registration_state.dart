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
  const RegistrationSuccess();
}

final class RegistrationFailure extends RegistrationState {
  const RegistrationFailure();
}
