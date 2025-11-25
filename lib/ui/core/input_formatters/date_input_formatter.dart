import 'dart:math';
import 'package:flutter/services.dart';

class UniversalDateInputFormatter extends TextInputFormatter {
  final String separator;

  /// Например [2, 2, 4] (ДД.ММ.ГГГГ) или [4, 2, 2] (YYYY.MM.DD)
  final List<int> segmentLengths;

  UniversalDateInputFormatter({
    required this.separator,
    required this.segmentLengths,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    final totalLength = segmentLengths.reduce((a, b) => a + b);

    if (newText.length > totalLength) {
      newText = newText.substring(0, totalLength);
    }

    // Формируем строку с разделителями динамически
    final buffer = StringBuffer();
    int currentSegmentIndex = 0;
    int currentSegmentLength = 0;

    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      currentSegmentLength++;

      // Проверяем, нужно ли ставить разделитель
      // Если мы достигли длины текущего сегмента И это не последний сегмент
      if (currentSegmentIndex < segmentLengths.length - 1 &&
          currentSegmentLength == segmentLengths[currentSegmentIndex]) {
        buffer.write(separator);
        currentSegmentLength = 0; // Сброс счетчика для следующего сегмента
        currentSegmentIndex++;
      }
    }

    final String formattedText = buffer.toString();

    final bool isDeletion = newValue.text.length < oldValue.text.length;

    final currentSelectionOffset = newValue.selection.baseOffset;

    // *********** Начало логики расчета курсора ***********
    int digitsBeforeCursor = 0;
    // Считаем реальные цифры до курсора в исходном вводе (newValue)
    for (
      int i = 0;
      i < min(currentSelectionOffset, newValue.text.length);
      i++
    ) {
      if (RegExp('[0-9]').hasMatch(newValue.text[i])) {
        digitsBeforeCursor++;
      }
    }

    int newCursorOffset = 0;
    int digitsEncountered = 0;

    for (int i = 0; i < formattedText.length; i++) {
      if (RegExp('[0-9]').hasMatch(formattedText[i])) {
        digitsEncountered++;
      }

      if (digitsEncountered == digitsBeforeCursor) {
        newCursorOffset = i + 1;

        // Если это не удаление И следующий символ - разделитель,
        // перешагиваем его для удобства ввода
        if (!isDeletion &&
            newCursorOffset < formattedText.length &&
            formattedText[newCursorOffset] == separator) {
          newCursorOffset += 1;
        }

        // Если это было удаление, мы хотим, чтобы курсор остался точно
        // на месте, где был удален символ.
        //
        // Если курсор находится сразу перед разделителем,
        // мы должны его оставить там, чтобы Backspace мог удалить цифру.

        // Если это удаление, и мы сейчас стоим на разделителе,
        // то курсор должен вернуться на позицию перед ним.
        if (isDeletion &&
            newCursorOffset > 0 &&
            formattedText[newCursorOffset - 1] == separator) {
          // Курсор должен встать на позицию, где была цифра перед разделителем
          newCursorOffset--;
        }

        break;
      }
    }

    // Корректировка newCursorOffset по краям: 0 и formattedText.length
    if (digitsBeforeCursor == 0) newCursorOffset = 0;
    if (newCursorOffset > formattedText.length) {
      newCursorOffset = formattedText.length;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newCursorOffset),
    );
  }
}
