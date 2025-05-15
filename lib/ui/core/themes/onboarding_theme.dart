import 'package:flutter/material.dart';

class OnboardingTheme {
  final bool _isLightMode;

  const OnboardingTheme({required Brightness brightness})
    : _isLightMode = brightness == Brightness.light;

  Color get surfaceColor => _isLightMode ? _lightColor : _darkColor;

  Color get statusBarColor =>
      _isLightMode ? _topGradientColorLight : _topGradientColorDark;

  Color get systemNavigationBarColor =>
      _isLightMode ? _botGradientColorLight : _botGradientColorDark;

  Gradient get gradient {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        if (_isLightMode) _topGradientColorLight else _topGradientColorDark,
        if (_isLightMode) _midGradientColorLight else _midGradientColorDark,
        if (_isLightMode) _botGradientColorLight else _botGradientColorDark,
      ],
      stops: const [0.0, 0.5, 1.0],
    );
  }

  static const _lightColor = Color(0xFF356CF9);
  static const _darkColor = Color(0xFF00174D);

  static const _topGradientColorLight = _lightColor;
  static const _midGradientColorLight = Color(0xFF83ABFC);
  static const _botGradientColorLight = Color(0xFFFFFFFF);

  static const _topGradientColorDark = _darkColor;
  static const _midGradientColorDark = Color(0xFF00174D);
  static const _botGradientColorDark = Color(0xFF1C1B1F);
}
