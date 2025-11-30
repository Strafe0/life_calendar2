import 'package:flutter/material.dart';

extension BrightnessCheck on Brightness {
  bool get isDarkMode => this == Brightness.dark;
  bool get isLightMode => this == Brightness.light;

  Brightness get inverse => isDarkMode ? Brightness.light : Brightness.dark;
}
