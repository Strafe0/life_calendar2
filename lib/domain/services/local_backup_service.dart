import 'package:life_calendar2/utils/result.dart';

abstract class LocalBackupService {
  Future<bool> exportCalendar();
  Future<Result<bool>> importCalendar();
}
