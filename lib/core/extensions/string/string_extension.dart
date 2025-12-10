import 'package:intl/intl.dart';
import 'package:life_calendar/core/logger/logger.dart';

extension StringExtension on String {
  /// Преобразует строку в дату с учетом локали или конкретного паттерна.
  ///
  /// [locale] - например 'en_US' или 'ru_RU'.
  /// Если null, используется системная.
  ///
  /// [pattern] - жесткий паттерн, например 'dd.MM.yyyy'.
  /// Если задан, locale игнорируется.
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
      // Используем ваш логгер
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
