// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';

// Note: No base themes.
// ! Cannot start with 'base' theme.
// ! Although no colors applied, having base class instance
// ! both dark/light copyWith() from results in funky ness related to colors.

// ! https://stackoverflow.com/questions/76791329/how-to-share-base-theme-between-light-dark-theme-material-3-flutter

// final base = ThemeData(
//   useMaterial3: true,
//   colorSchemeSeed: const Color(0xFF2C6C2F),
//   ...
// );

// Note: Hot restart not reload after editing themes to see changes reflected in UI.

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorSchemeSeed: const Color(0xFF2C6C2F),
  textTheme: const TextTheme(
    bodySmall: TextStyle(),
    bodyMedium: TextStyle(),
    bodyLarge: TextStyle(),
    titleSmall: TextStyle(),
    titleMedium: TextStyle(),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ).apply(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorSchemeSeed: const Color(0xFF2C6C2F),
  textTheme: const TextTheme(
    bodySmall: TextStyle(),
    bodyMedium: TextStyle(),
    bodyLarge: TextStyle(),
    titleSmall: TextStyle(),
    titleMedium: TextStyle(),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ).apply(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);

Color C(BuildContext context, String key) {
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
    case 'surfaceVariant':
      return colorScheme.surfaceVariant;
    case 'inverseSurface':
      return colorScheme.inverseSurface;
    case 'onInverseSurface':
      return colorScheme.onInverseSurface;
    case 'inversePrimary':
      return colorScheme.inversePrimary;
    case 'onPrimaryContainer':
      return colorScheme.onPrimaryContainer;
    case 'outline':
      return colorScheme.outline;
    case 'tertiary':
      return colorScheme.tertiary;
    case 'background':
      return colorScheme.background;
    case 'secondaryContainer':
      return colorScheme.secondaryContainer;
    case 'error':
      return colorScheme.error;
    case 'onError':
      return colorScheme.onError;
    case 'onErrorContainer':
      return colorScheme.onErrorContainer;
    case 'shadow':
      return colorScheme.shadow;
    default:
      throw Exception('Invalid color key: $key');
  }
}

bool isDarkMode(BuildContext context) {
  final theme = Theme.of(context).brightness;
  return theme == Brightness.dark;
}

TextStyle styleWithColor({required TextStyle type, Color? color}) {
  return type.copyWith(
    color: color ?? type.color,
  );
}

T(BuildContext context, String key) {
  final theme = Theme.of(context);
  switch (key) {
    case 'bodySmall':
      return theme.textTheme.bodySmall;
    case 'bodyMedium':
      return theme.textTheme.bodyMedium;
    case 'bodyLarge':
      return theme.textTheme.bodyLarge;
    case 'labelSmall':
      return theme.textTheme.labelSmall;
    case 'labelMedium':
      return theme.textTheme.labelMedium;
    case 'labelLarge':
      return theme.textTheme.labelLarge;
    case 'titleSmall':
      return theme.textTheme.titleSmall;
    case 'titleMedium':
      return theme.textTheme.titleMedium;
    case 'titleLarge':
      return theme.textTheme.titleLarge;
    case 'headlineSmall':
      return theme.textTheme.headlineSmall;
    case 'headlineMedium':
      return theme.textTheme.headlineMedium;
    case 'headlineLarge':
      return theme.textTheme.headlineLarge;
    case 'displaySmall':
      return theme.textTheme.displaySmall;
    case 'displayMedium':
      return theme.textTheme.displayMedium;
    case 'displayLarge':
      return theme.textTheme.displayLarge;
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
