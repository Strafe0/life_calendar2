import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  final String separator;

  const DateInputFormatter({required this.separator});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    text = text.replaceAll(RegExp('[^0-9]'), '');

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);

      if ((i == 1 || i == 3) && i != text.length - 1) {
        buffer.write('.');
      }
    }

    final String formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
