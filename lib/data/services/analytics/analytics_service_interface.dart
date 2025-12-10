import 'package:life_calendar/domain/models/week/week_assessment/week_assessment.dart';

enum WeekContentEvent { goal, event, photo, resume }

enum BackupEvent { export, import }

enum WeekTransitionEvent { currentWeek, weekBox, search }

enum DonateStep { open, goToDonation }

abstract class AnalyticsService {
  Future<void> logAddWeekContent(WeekContentEvent type);
  Future<void> logDeleteWeekContent(WeekContentEvent type);
  Future<void> logChangeWeekContent(WeekContentEvent type);
  Future<void> logAssessmentChange(WeekAssessment assessement);
  Future<void> logBackup(BackupEvent event);
  Future<void> logWeekOpening(WeekTransitionEvent event);
  Future<void> logDonate(DonateStep step);
  Future<void> logChangeLifespan(int oldValue, int newValue);
  Future<void> logRegistration(DateTime birthdate, int lifeSpan);
}
