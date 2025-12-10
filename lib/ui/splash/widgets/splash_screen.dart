import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/extensions/brightness_extension.dart';
import 'package:life_calendar2/core/navigation/app_routes.dart';
import 'package:life_calendar2/data/services/notifications/local_notification_service.dart';
import 'package:life_calendar2/data/services/settings_service.dart';
import 'package:life_calendar2/domain/interactor/weekly_notification_interactor.dart';
import 'package:life_calendar2/ui/splash/bloc/splash_cubit.dart';
import 'package:life_calendar2/ui/splash/bloc/splash_state.dart';
import 'package:life_calendar2/ui/user/bloc/user_bloc.dart';
import 'package:life_calendar2/ui/user/bloc/user_event.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    MobileAds.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: ColorScheme.of(context).surface,
        statusBarIconBrightness:
            Theme.brightnessOf(context).isDarkMode
                ? Brightness.light
                : Brightness.dark,
      ),
      child: BlocProvider(
        create:
            (context) => SplashCubit(
              databaseService: context.read(),
              userRepository: context.read(),
              weeklyNotificationInteractor: WeeklyNotificationInteractor(
                context.read<LocalNotificationService>(),
                const SettingsService(),
              ),
            )..prepareApp(),
        child: Builder(
          builder: (context) {
            return BlocListener<SplashCubit, SplashState>(
              listener: (context, state) {
                switch (state) {
                  case SplashInitial():
                  case SplashLoading():
                    break;
                  case SplashReady():
                    if (state.isAuthenticated) {
                      context.read<UserBloc>().add(UserReceived(state.user));
                      context.go(AppRoute.calendar);
                    } else {
                      context.go(AppRoute.onboarding);
                    }
                  case SplashFailure():
                    context.go(AppRoute.error);
                }
              },
              child: const SafeArea(
                child: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
