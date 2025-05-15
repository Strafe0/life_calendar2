// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,

      primary: Color(0xFF0151DF),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFDBE1FF),
      onPrimaryContainer: Color(0xFF00174D),

      secondary: Color(0xFF595E72),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFDDE1F9),
      onSecondaryContainer: Color(0xFF161B2C),

      tertiary: Color(0xFF745470),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFFFD6F7),
      onTertiaryContainer: Color(0xFF2B122A),

      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),

      surface: Color(0xFFFBF8FD),
      onSurface: Color(0xFF1B1B1F),

      surfaceContainerHighest: Color(0xFFE2E1EC),
      onSurfaceVariant: Color(0xFF45464F),
      outline: Color(0xFF767680),
    ),

    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 1.45,
      ),

      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 1.2,
        letterSpacing: 0.5,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.1,
      ),

      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.45,
        letterSpacing: 0.5,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.5,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: 0.4,
      ),
    ),

    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 1.2,
        letterSpacing: 0.5,
      ), //titleLarge
      backgroundColor: Color(0xFF0151DF), //primary
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF003CAC),
      ),
      iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF0151DF), // primary
      foregroundColor: Color(0xFFFFFFFF), // onPrimary
    ),

    iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Color(0xFF0151DF)),
        foregroundColor: const WidgetStatePropertyAll(Color(0xFFFFFFFF)),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.43,
            letterSpacing: 0.1,
          ),
        ),
        elevation: WidgetStateProperty.resolveWith((states) {
          const Set<WidgetState> interactiveStates = <WidgetState>{
            WidgetState.pressed,
            WidgetState.hovered,
            WidgetState.focused,
          };
          if (states.any(interactiveStates.contains)) {
            return 0;
          }
          return 8;
        }),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF1B1B1F)),
      ),
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.5,
      ),
    ),

    cardTheme: const CardTheme(
      color: Color(0xFFF2F0F4),
      surfaceTintColor: Colors.transparent,
      elevation: 1,
    ),

    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFF2F0F4),
      surfaceTintColor: Colors.transparent,
    ),

    popupMenuTheme: const PopupMenuThemeData(
      color: Color(0xFFF2F0F4),
      surfaceTintColor: Colors.transparent,
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.5,
      ),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xFF0151DF),
      strokeCap: StrokeCap.round,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,

      primary: Color(0xFFB5C4FF),
      onPrimary: Color(0xFF00297A),
      primaryContainer: Color(0xFF003CAB),
      onPrimaryContainer: Color(0xFFDBE1FF),

      secondary: Color(0xFFC1C5DD),
      onSecondary: Color(0xFF2B3042),
      secondaryContainer: Color(0xFF414659),
      onSecondaryContainer: Color(0xFFDDE1F9),

      tertiary: Color(0xFFE2BBDB),
      onTertiary: Color(0xFF422740),
      tertiaryContainer: Color(0xFF5B3D57),
      onTertiaryContainer: Color(0xFFFFD6F7),

      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),

      surface: Color(0xFF131316),
      onSurface: Color(0xFFC7C6CA),

      surfaceContainerHighest: Color(0xFF45464F),
      onSurfaceVariant: Color(0xFFC6C6D0),
      outline: Color(0xFF8F909A),
    ),

    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 1.45,
      ),

      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 1.2,
        letterSpacing: 0.5,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.1,
      ),

      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.45,
        letterSpacing: 0.5,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.5,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: 0.4,
      ),
    ),

    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Color(0xFFC7C6CA),
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 1.2,
        letterSpacing: 0.5,
      ), //titleLarge
      backgroundColor: Color(0xFF303034), //primary
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1B1B1F),
      ),
      iconTheme: IconThemeData(color: Color(0xFFC7C6CA)),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFB5C4FF), // primary
      foregroundColor: Color(0xFF00297A), // onPrimary
    ),

    iconTheme: const IconThemeData(color: Color(0xFFC7C6CA)),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Color(0xFFB5C4FF)),
        foregroundColor: const WidgetStatePropertyAll(Color(0xFF00297A)),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.43,
            letterSpacing: 0.1,
          ),
        ),
        elevation: WidgetStateProperty.resolveWith((states) {
          const Set<WidgetState> interactiveStates = <WidgetState>{
            WidgetState.pressed,
            WidgetState.hovered,
            WidgetState.focused,
          };
          if (states.any(interactiveStates.contains)) {
            return 0;
          }
          return 8;
        }),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE4E2E6)),
      ),
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.5,
      ),
    ),

    cardTheme: const CardTheme(
      color: Color(0xFF303034),
      surfaceTintColor: Colors.transparent,
      elevation: 2,
    ),

    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF303034),
      surfaceTintColor: Colors.transparent,
    ),

    popupMenuTheme: const PopupMenuThemeData(
      color: Color(0xFF303034),
      surfaceTintColor: Colors.transparent,
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.5,
      ),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xFFB5C4FF),
      strokeCap: StrokeCap.round,
    ),
  );
}
