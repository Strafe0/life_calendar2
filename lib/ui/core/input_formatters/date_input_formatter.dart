import 'dart:math';
import 'package:flutter/services.dart';

class UniversalDateInputFormatter extends TextInputFormatter {
  final String separator;

  /// For example [2, 2, 4] (DD.MM.YYYY) or [4, 2, 2] (YYYY.MM.DD)
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

    // Build the string with separators dynamically
    final buffer = StringBuffer();
    int currentSegmentIndex = 0;
    int currentSegmentLength = 0;

    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      currentSegmentLength++;

      // Check whether a separator is needed
      // If we reached the current segment length AND it's not the last segment
      if (currentSegmentIndex < segmentLengths.length - 1 &&
          currentSegmentLength == segmentLengths[currentSegmentIndex]) {
        buffer.write(separator);
        currentSegmentLength = 0; // Reset the counter for the next segment
        currentSegmentIndex++;
      }
    }

    final String formattedText = buffer.toString();

    final bool isDeletion = newValue.text.length < oldValue.text.length;

    final currentSelectionOffset = newValue.selection.baseOffset;

    // *********** Start of cursor calculation logic ***********
    int digitsBeforeCursor = 0;
    // Count the actual digits before the cursor in the raw input (newValue)
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

        // If this isn't a deletion AND the next char is a separator,
        // step over it for input convenience
        if (!isDeletion &&
            newCursorOffset < formattedText.length &&
            formattedText[newCursorOffset] == separator) {
          newCursorOffset += 1;
        }

        // On deletion we want the cursor to stay exactly where the character
        // was removed.
        //
        // If the cursor sits right before a separator, we keep it there so
        // Backspace can delete the digit.

        // If this is a deletion and we're currently on a separator,
        // the cursor should move back to the position before it.
        if (isDeletion &&
            newCursorOffset > 0 &&
            formattedText[newCursorOffset - 1] == separator) {
          // Place the cursor where the digit before the separator was
          newCursorOffset--;
        }

        break;
      }
    }

    // Clamp newCursorOffset to the edges: 0 and formattedText.length
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
