import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar/data/services/settings_service.dart';
import 'package:life_calendar/domain/interactor/weekly_notification_interactor.dart';
import 'package:life_calendar/utils/result.dart';

// Simple settings state
class SettingsState {
  final bool isWeeklyReminderEnabled;
  SettingsState({required this.isWeeklyReminderEnabled});
}

class SettingsCubit extends Cubit<SettingsState> {
  final WeeklyNotificationInteractor _interactor;
  final SettingsService _settingsService;

  SettingsCubit(this._interactor, this._settingsService)
    : super(SettingsState(isWeeklyReminderEnabled: true));

  /// Loads the initial toggle state when the screen is opened
  Future<void> loadSettings() async {
    final isEnabled = await _settingsService.isWeeklyReminderEnabled();
    emit(SettingsState(isWeeklyReminderEnabled: isEnabled));
  }

  /// User toggled the switch
  // ignore: avoid_positional_boolean_parameters
  Future<void> toggleReminder(bool value) async {
    emit(SettingsState(isWeeklyReminderEnabled: value));

    final result = await _interactor.toggleNotification(isEnabled: value);

    if (result is ResultError<void>) {
      emit(SettingsState(isWeeklyReminderEnabled: !value));
    }
  }
}
