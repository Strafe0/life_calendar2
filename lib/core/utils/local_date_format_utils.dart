import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:life_calendar2/core/constants/constants.dart';
import 'package:life_calendar2/core/l10n/app_localizations.dart';

String getLocalizedHint({
  required String pattern,
  required AppLocalizations l10n,
  List<int>? segmentLengths,
}) {
  // 1. Находим позиции символов
  final dIndex = pattern.indexOf('d');
  final mIndex = pattern.indexOf('M');
  final yIndex = pattern.indexOf('y');

  // 2. Создаем карту {index: char} и сортируем ключи,
  // чтобы понимать реальный порядок следования в строке
  final indexMap = <int, String>{};
  if (dIndex != -1) indexMap[dIndex] = 'd';
  if (mIndex != -1) indexMap[mIndex] = 'M';
  if (yIndex != -1) indexMap[yIndex] = 'y';

  final sortedIndices = indexMap.keys.toList()..sort();

  // 3. Автоматическое определение длин, если они не переданы
  List<int> effectiveLengths = segmentLengths ?? [];

  if (effectiveLengths.isEmpty) {
    // Логика определения ISO формата (год в начале)
    // Проверяем, существует ли год, и идет ли он раньше дня
    // (или если дня нет вовсе)
    final isYearFirst = yIndex != -1 && (dIndex == -1 || yIndex < dIndex);

    if (isYearFirst) {
      // Пример: yyyy-MM-dd (Япония, ISO, Китай) -> 4, 2, 2
      effectiveLengths = [4, 2, 2];
    } else {
      // Пример: dd.MM.yyyy (РФ) или MM/dd/yyyy (США) -> 2, 2, 4
      effectiveLengths = [2, 2, 4];
    }
  }

  String result = pattern;

  // 4. Применяем замену по порядку появления символов
  for (int i = 0; i < sortedIndices.length; i++) {
    // Безопасно берем длину.
    // Если символов меньше, чем длин в массиве — берем i-ю.
    // Если длин в массиве не хватает — берем последнюю доступную или дефолт 2.
    final length =
        (i < effectiveLengths.length)
            ? effectiveLengths[i]
            : (effectiveLengths.isNotEmpty ? effectiveLengths.last : 2);

    final charOriginalIndex = sortedIndices[i];
    final char = indexMap[charOriginalIndex]!;

    // Выбираем символ из локализации
    String localizedSymbol;
    switch (char) {
      case 'd':
        localizedSymbol = l10n.daySymbol;
      case 'M':
        localizedSymbol = l10n.monthSymbol;
      case 'y':
        localizedSymbol = l10n.yearSymbol;
      default:
        localizedSymbol = char;
    }

    // Заменяем (например 'd' -> 'ДД')
    // Используем replaceFirst, чтобы не задеть другие похожие символы,
    // если они вдруг есть
    result = result.replaceFirst(char, localizedSymbol * length);
  }

  return result;
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
