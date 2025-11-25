import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:life_calendar2/core/constants/constants.dart';
import 'package:life_calendar2/core/l10n/app_localizations.dart';

String getLocalizedHint(String pattern, AppLocalizations l10n) {
  return pattern
      .replaceAll('d', l10n.daySymbol)
      .replaceAll('M', l10n.monthSymbol)
      .replaceAll('y', l10n.yearSymbol);
}

DateFormat getLocalDateFormat(Locale locale) {
  return DateFormat.yMd(locale.toString());
}

String getLocalDateSeparator(Locale locale) {
  final dateFormat = getLocalDateFormat(locale);
  final pattern = dateFormat.pattern ?? dateFormatPattern;

  return getLocalDateSeparatorByPattern(pattern);
}

String getLocalDateSeparatorByPattern(String pattern) {
  // Определяем разделитель (первый не-буквенный символ)
  final separatorMatch = RegExp('[^a-zA-Z]').firstMatch(pattern);
  return separatorMatch?.group(0) ?? '.';
}
