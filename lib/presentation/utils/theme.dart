// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';

ThemeData base = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.white),
    labelStyle: TextStyle(color: Colors.grey),
    helperStyle: TextStyle(color: Colors.blue),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      textStyle: const TextStyle(fontSize: 15, color: Colors.red),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.green,
      textStyle: const TextStyle(fontSize: 15),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      side: const BorderSide(
        color: Colors.green,
      ),
    ),
  ),
);

final darkTheme = base.copyWith(
  brightness: Brightness.dark,
  indicatorColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(
    bodySmall: TextStyle(),
    bodyMedium: TextStyle(),
    bodyLarge: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  listTileTheme: const ListTileThemeData(
    textColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
  ),
  colorScheme: const ColorScheme.dark(
    outline: Colors.grey,
    primary: Colors.green,
    surface: Colors.black38,
    onError: Color(0xFFC62828),
    tertiary: Color(0xFF30BFBF),
    secondary: Color(0xFF227C9D),
    inversePrimary: Colors.white,
    primaryContainer: Colors.black,
    onPrimaryContainer: Colors.black,
    secondaryContainer: Colors.black38,
    onErrorContainer: Color(0xFFC62828),
  ),
);

final lightTheme = base.copyWith(
  brightness: Brightness.light,
  indicatorColor: Colors.black,
  textTheme: const TextTheme(
    bodySmall: TextStyle(),
    bodyMedium: TextStyle(),
    bodyLarge: TextStyle(),
  ).apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  listTileTheme: const ListTileThemeData(
    textColor: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
  ),
  colorScheme: const ColorScheme.light(
    outline: Colors.grey,
    primary: Colors.green,
    surface: Colors.white,
    onError: Color(0xFFC62828),
    inversePrimary: Colors.black,
    secondary: Color(0xFF227C9D),
    tertiary: Color(0xFF30BFBF),
    primaryContainer: Colors.white,
    onPrimaryContainer: Colors.white,
    secondaryContainer: Colors.white,
    onErrorContainer: Color(0xFFC62828),
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
