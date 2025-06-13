import 'package:flutter/material.dart';

extension DarkMode on ThemeData {
  bool get isDarkMode => brightness == Brightness.dark; 
}