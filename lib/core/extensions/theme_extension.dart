import 'package:flutter/material.dart';

extension DarkMode on ThemeData {
  bool get isDarkMode => brightness == Brightness.dark;
  Brightness get inverseBrightness =>
      isDarkMode ? Brightness.light : Brightness.dark;
}
