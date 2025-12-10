import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:life_calendar/core/logger/logger.dart';

extension DateTimeExtension on DateTime {
  int toTimeStamp() => Duration(milliseconds: millisecondsSinceEpoch).inSeconds;

  String toLocalString(BuildContext context) {
    try {
      final locale = Localizations.localeOf(context).toLanguageTag();
      return DateFormat.yMd(locale).format(this);
    } catch (e, s) {
      logger.w(
        'Failed format date to localized string',
        error: e,
        stackTrace: s,
      );
      return toString();
    }
  }

  static DateTime fromFlexibleTimestamp(int timestamp) {
    // Пороговое значение: 100 миллиардов.
    // Если число меньше — это секунды (хватит до 5138 года).
    // Если больше — это миллисекунды.
    const int threshold = 100000000000;

    if (timestamp < threshold) {
      // Это секунды: переводим в миллисекунды
      return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    } else {
      // Это уже миллисекунды
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
  }
}
