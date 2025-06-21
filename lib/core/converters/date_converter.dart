import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:life_calendar2/core/logger.dart';

class DateConverter implements JsonConverter<DateTime, int> {
  const DateConverter();

  @override
  DateTime fromJson(int json) {
    try {
      return DateTime.fromMillisecondsSinceEpoch(json);
    } on FormatException catch (e, s) {
      logger.e(
        'Failed to parse DateTime from $json. Return "now".',
        error: e,
        stackTrace: s,
      );
      return DateTime.now();
    }
  }

  @override
  int toJson(DateTime date) => date.millisecondsSinceEpoch;
}
