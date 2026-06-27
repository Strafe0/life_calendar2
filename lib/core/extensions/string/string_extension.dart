import 'package:intl/intl.dart';
import 'package:life_calendar/core/logger/logger.dart';

extension StringExtension on String {
  /// Parses the string into a date using a locale or a specific pattern.
  ///
  /// [locale] — for example 'en_US' or 'ru_RU'.
  /// If null, the system locale is used.
  ///
  /// [pattern] — a fixed pattern, for example 'dd.MM.yyyy'.
  /// If set, [locale] is ignored.
  DateTime? toDateTime({String? locale, String? pattern}) {
    if (isEmpty) return null;

    try {
      late DateFormat format;

      if (pattern != null) {
        format = DateFormat(pattern);
      } else {
        format = DateFormat.yMd(locale);
      }

      final DateTime date = format.parse(this);

      return date;
    } catch (e, s) {
      logger.w(
        'Cannot parse string "$this" to date using '
        'locale: $locale, pattern: $pattern',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }
}
