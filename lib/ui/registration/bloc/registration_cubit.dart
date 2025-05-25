import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/repositories/auth_repository/auth_repository.dart';
import 'package:life_calendar2/ui/registration/bloc/registration_state.dart';
import 'package:life_calendar2/utils/result.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final AuthRepository _authRepository;

  RegistrationCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const RegistrationInitial());

  Future<void> register({
    required DateTime birthday,
    required int lifeSpan,
  }) async {
    emit(const RegistrationLoading());
    logger.d('Started registration');

    final result = await _authRepository.register(
      birthday: birthday,
      lifeSpan: lifeSpan,
    );

    switch (result) {
      case Ok():
        logger.d('Successfully registered');
        emit(const RegistrationSuccess());
      case Error():
        logger.d('Registration is failed', error: result.error);
        emit(const RegistrationFailure());
    }
  }
}
