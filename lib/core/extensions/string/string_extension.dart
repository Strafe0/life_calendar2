import 'package:life_calendar2/core/logger.dart';

extension StringExtension on String {
  DateTime? toDateTime({String delimiter = '.'}) {
    final splitted = split(delimiter);
    if (splitted.length != 3) {
      logger.w('Cannot parse string "$this" to date');
      return null;
    }

    final day = int.tryParse(splitted[0]);
    final month = int.tryParse(splitted[1]);
    final year = int.tryParse(splitted[2]);

    if (day == null || month == null || year == null) {
      logger.w('Cannot parse string "$this" to date');
      return null;
    }

    return DateTime(year, month, day);
  }
}
