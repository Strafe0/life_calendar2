import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/repositories/user_repository/user_repository.dart';
import 'package:life_calendar2/domain/models/user/user.dart';
import 'package:life_calendar2/ui/user/bloc/user_event.dart';
import 'package:life_calendar2/ui/user/bloc/user_state.dart';
import 'package:life_calendar2/utils/result.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(const UserInitial()) {
    on<UserReceived>((event, emit) => emit(UserSuccess(user: event.user)));
    on<UserLoadingTriggered>(_getUser);
  }

  int? get age => state is UserSuccess ? (state as UserSuccess).user.age : null;

  Future<void> _getUser(UserEvent event, Emitter<UserState> emit) async {
    emit(const UserLoading());

    final userResult = await _userRepository.getUser();

    switch (userResult) {
      case Ok<User>():
        logger.d(
          'Got user ${userResult.value.id} '
          '(${userResult.value.birthdate}, '
          '${userResult.value.lifeSpan})',
        );
        emit(UserSuccess(user: userResult.value));
      case Error<User>():
        logger.d('Failed to get user', error: userResult.error);
        emit(UserFailure(userResult.error));
    }
  }
}
