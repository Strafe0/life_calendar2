import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/data/repositories/user_repository/user_repository.dart';
import 'package:life_calendar2/data/services/database_service.dart';
import 'package:life_calendar2/domain/interactor/weekly_notification_interactor.dart';
import 'package:life_calendar2/domain/models/user/user.dart';
import 'package:life_calendar2/ui/splash/bloc/splash_state.dart';
import 'package:life_calendar2/utils/result.dart';

class SplashCubit extends Cubit<SplashState> {
  final DatabaseService _databaseService;
  final UserRepository _userRepository;
  final WeeklyNotificationInteractor _weeklyNotificationInteractor;

  SplashCubit({
    required DatabaseService databaseService,
    required UserRepository userRepository,
    required WeeklyNotificationInteractor weeklyNotificationInteractor,
  }) : _databaseService = databaseService,
       _userRepository = userRepository,
       _weeklyNotificationInteractor = weeklyNotificationInteractor,
       super(const SplashInitial());

  Future<void> prepareApp() async {
    emit(const SplashLoading());
    final result = await _databaseService.init();
    final userResult = await _userRepository.getUser();

    await _prepareNotifications();

    if (result is Ok && userResult is Ok<User>) {
      emit(SplashReady(user: userResult.value));
    } else {
      emit(const SplashFailure());
    }
  }

  Future<void> _prepareNotifications() async {
    await _weeklyNotificationInteractor.initializeWithPermissions();
    await _weeklyNotificationInteractor.checkAndScheduleAtStartup();
  }
}
