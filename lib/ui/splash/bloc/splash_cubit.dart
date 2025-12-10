import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar/data/repositories/user_repository/user_repository.dart';
import 'package:life_calendar/data/services/database_service.dart';
import 'package:life_calendar/data/services/shared_preferences_service.dart';
import 'package:life_calendar/domain/interactor/weekly_notification_interactor.dart';
import 'package:life_calendar/domain/models/user/user.dart';
import 'package:life_calendar/ui/splash/bloc/splash_state.dart';
import 'package:life_calendar/utils/result.dart';

class SplashCubit extends Cubit<SplashState> {
  final DatabaseService _databaseService;
  final UserRepository _userRepository;
  final SharedPreferencesService _sharedPreferencesService;
  final WeeklyNotificationInteractor _weeklyNotificationInteractor;

  SplashCubit({
    required DatabaseService databaseService,
    required UserRepository userRepository,
    required WeeklyNotificationInteractor weeklyNotificationInteractor,
    required SharedPreferencesService sharedPreferencesService,
  }) : _databaseService = databaseService,
       _userRepository = userRepository,
       _weeklyNotificationInteractor = weeklyNotificationInteractor,
       _sharedPreferencesService = sharedPreferencesService,
       super(const SplashInitial());

  Future<void> prepareApp() async {
    emit(const SplashLoading());
    final result = await _databaseService.init();
    final userResult = await _userRepository.getUser();
    final isFirstLaunchV3 = await _sharedPreferencesService.isFirstLaunchV3();

    await _prepareNotifications();

    if (result is Ok && userResult is Ok<User>) {
      await _sharedPreferencesService.setFirstLaunchV3(isFirstLaunch: false);
      emit(
        SplashReady(user: userResult.value, isFirstLaunchV3: isFirstLaunchV3),
      );
    } else {
      emit(const SplashFailure());
    }
  }

  Future<void> _prepareNotifications() async {
    await _weeklyNotificationInteractor.initializeWithPermissions();
    await _weeklyNotificationInteractor.checkAndScheduleAtStartup();
  }
}
