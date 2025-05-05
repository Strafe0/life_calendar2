import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/models/user/user.dart';
import 'package:life_calendar2/domain/repositories/user_repository.dart';
import 'package:life_calendar2/ui/user/bloc/user_state.dart';
import 'package:life_calendar2/utils/result.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(const UserInitial());

  Future<void> getUser() async {
    emit(const UserLoading());

    final userResult = await _userRepository.getUser();

    switch (userResult) {
      case Ok<User>():
        logger.d('Got user ${userResult.value.id}');
        emit(UserSuccess(user: userResult.value));
      case Error<User>():
        logger.d('Failed to get user', error: userResult.error);
        emit(UserFailure(userResult.error));
    }
  }
}
