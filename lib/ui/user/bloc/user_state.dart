import 'package:equatable/equatable.dart';
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

final class UserSuccess extends UserState with Equatable {
  final User user;

  const UserSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

final class UserFailure extends UserState with Equatable {
  final Object exception;

  const UserFailure(this.exception);

  @override
  List<Object?> get props => [exception];
}
