// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';

// Note:
// ! Cannot start with 'base' theme.
// ! Although no colors applied, having base class which
// ! both dark/light copyWith() from results in funky ness related to colors.

// ! Make sure to hot restart not reload
// ! after editing themes to see changes reflected in UI.

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  indicatorColor: Colors.white,
  colorSchemeSeed: const Color(0xFF2C6C2F),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(),
    bodyMedium: TextStyle(),
    bodyLarge: TextStyle(),
    titleSmall: TextStyle(),
    titleMedium: TextStyle(),
    titleLarge: TextStyle(fontSize: 25),
  ).apply(),
  cardTheme: const CardTheme(),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.grey),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 15),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  indicatorColor: Colors.black,
  colorSchemeSeed: const Color(0xFF2C6C2F),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(),
    bodyMedium: TextStyle(),
    bodyLarge: TextStyle(),
    titleSmall: TextStyle(),
    titleMedium: TextStyle(),
    titleLarge: TextStyle(fontSize: 25),
  ).apply(),
  cardTheme: const CardTheme(),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.grey),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF2C6C2F),
      textStyle: const TextStyle(fontSize: 15),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF2C6C2F),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      side: const BorderSide(
        color: Color(0xFF2C6C2F),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);

bool isDarkMode(BuildContext context) {
  final theme = Theme.of(context).brightness;
  return theme == Brightness.dark;
}

Color T(BuildContext context, String key) {
  final colorScheme = Theme.of(context).colorScheme;
  switch (key) {
    case 'primary':
      return colorScheme.primary;
    case 'primaryContainer':
      return colorScheme.primaryContainer;
    case 'secondary':
      return colorScheme.secondary;
    case 'surface':
      return colorScheme.surface;
    case 'inversePrimary':
      return colorScheme.inversePrimary;
    case 'onPrimaryContainer':
      return colorScheme.onPrimaryContainer;
    case 'outline':
      return colorScheme.outline;
    case 'tertiary':
    case 'background':
      return colorScheme.background;
    case 'secondaryContainer':
      return colorScheme.secondaryContainer;
    case 'onError':
      return colorScheme.onError;
    case 'onErrorContainer':
      return colorScheme.onErrorContainer;
    default:
      throw Exception('Invalid color key: $key');
  }
}

class ThemeModel with ChangeNotifier {
  bool _isDarkMode = window.platformBrightness == Brightness.dark;

  ThemeModel() {
    window.onPlatformBrightnessChanged = _handleBrightnessChange;
  }

  bool get isDarkMode => _isDarkMode;

  @override
  void dispose() {
    window.onPlatformBrightnessChanged = null;
    super.dispose();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void _handleBrightnessChange() {
    _isDarkMode = window.platformBrightness == Brightness.dark;
    notifyListeners();
  }
}
