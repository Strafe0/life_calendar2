import 'package:life_calendar2/domain/models/user/user.dart';

sealed class UserEvent {
  const UserEvent();
}

final class UserReceived extends UserEvent {
  final User user;

  const UserReceived(this.user);
}

final class UserLoadingTriggered extends UserEvent {
  const UserLoadingTriggered();
}

final class UserChangeLifeSpanRequested extends UserEvent {
  final int lifeSpan;

  const UserChangeLifeSpanRequested(this.lifeSpan);
}
