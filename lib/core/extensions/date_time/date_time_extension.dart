import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:life_calendar2/core/logger.dart';

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
}
