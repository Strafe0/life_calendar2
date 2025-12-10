import 'package:life_calendar/utils/result.dart';

abstract class LocalBackupService {
  Future<bool> exportCalendar();
  Future<Result<bool>> importCalendar();
}
