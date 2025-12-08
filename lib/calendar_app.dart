import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/l10n/app_localizations.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/core/navigation/router.dart';
import 'package:life_calendar2/data/repositories/auth_repository/auth_repository.dart';
import 'package:life_calendar2/data/repositories/auth_repository/auth_repository_impl.dart';
import 'package:life_calendar2/data/repositories/onboarding_repository/onboarding_repository.dart';
import 'package:life_calendar2/data/repositories/onboarding_repository/onboarding_repository_impl.dart';
import 'package:life_calendar2/data/repositories/user_repository/user_repository.dart';
import 'package:life_calendar2/data/repositories/user_repository/user_repository_impl.dart';
import 'package:life_calendar2/data/repositories/week_repository/week_repository.dart';
import 'package:life_calendar2/data/repositories/week_repository/week_repository_impl.dart';
import 'package:life_calendar2/data/services/backup/cache_backup_strategy_impl.dart';
import 'package:life_calendar2/data/services/backup/database_backup_strategy_impl.dart';
import 'package:life_calendar2/data/services/backup/shared_prefs_backup_strategy_impl.dart';
import 'package:life_calendar2/data/services/database_service.dart';
import 'package:life_calendar2/data/services/image_picker_service_impl.dart';
import 'package:life_calendar2/data/services/local_backup_service_impl.dart';
import 'package:life_calendar2/data/services/shared_preferences_service.dart';
import 'package:life_calendar2/domain/services/image_picker_service.dart';
import 'package:life_calendar2/domain/services/local_backup_service.dart';
import 'package:life_calendar2/ui/core/themes/app_theme.dart';
import 'package:life_calendar2/ui/user/bloc/user_bloc.dart';
import 'package:provider/provider.dart';

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => DatabaseService()),
        Provider(create: (_) => const SharedPreferencesService()),
        Provider<ImagePickerService>(
          create: (_) => const ImagePickerServiceImpl(),
        ),
        Provider<OnboardingRepository>(
          create: (_) => const OnboardingRepositoryImpl(),
        ),
        Provider<AuthRepository>(
          create: (context) {
            return AuthRepositoryImpl(sharedPreferencesService: context.read());
          },
        ),
        Provider<UserRepository>(
          create:
              (context) => UserRepositoryImpl(
                sharedPreferencesService: context.read(),
                databaseService: context.read(),
              ),
        ),
        Provider<WeekRepository>(
          create:
              (context) => WeekRepositoryImpl(databaseService: context.read()),
        ),
        Provider<LocalBackupService>(
          create:
              (context) => LocalBackupServiceImpl(
                strategies: [
                  DatabaseBackupStrategy(databaseService: context.read()),
                  const SharedPreferencesBackupStrategy(),
                  const CacheBackupStrategy(),
                ],
              ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (context) => UserBloc(userRepository: context.read()),
            child: MaterialApp.router(
              title: 'Life Calendar',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              routerConfig: goRouter,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, widget) {
                Widget error = Center(child: Text(context.l10n.errorHappened));
                if (widget is Scaffold || widget is Navigator) {
                  error = Scaffold(body: error);
                }
                ErrorWidget.builder = (errorDetails) {
                  logger.e('Error building widget ${widget.runtimeType}');
                  return error;
                };
                if (widget != null) return widget;
                throw StateError('Widget is null');
              },
            ),
          );
        },
      ),
    );
  }
}
