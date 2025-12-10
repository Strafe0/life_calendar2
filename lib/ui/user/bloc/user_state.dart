import 'package:life_calendar/domain/models/user/user.dart';

sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();
}

final class UserLoading extends UserState {
  const UserLoading();
}

final class UserSuccess extends UserState {
  final User user;

  const UserSuccess({required this.user});
}

final class UserFailure extends UserState {
  final Object exception;

  const UserFailure(this.exception);
}
