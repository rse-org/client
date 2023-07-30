// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';

// Note: Hot restart not reload after editing themes to see changes reflected in UI.

ThemeData darkTheme = createTheme(Brightness.dark, shape);
ThemeData lightTheme = createTheme(Brightness.light, shape);

RoundedRectangleBorder shape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
);

Color C(BuildContext context, String key) {
  final cs = Theme.of(context).colorScheme;
  switch (key) {
    case 'primary':
      return cs.primary;
    case 'onPrimary':
      return cs.onPrimary;
    case 'primaryContainer':
      return cs.primaryContainer;
    case 'secondary':
      return cs.secondary;
    case 'onSecondary':
      return cs.onSecondary;
    case 'surface':
      return cs.surface;
    case 'surfaceVariant':
      return cs.surfaceVariant;
    case 'inverseSurface':
      return cs.inverseSurface;
    case 'onInverseSurface':
      return cs.onInverseSurface;
    case 'inversePrimary':
      return cs.inversePrimary;
    case 'onPrimaryContainer':
      return cs.onPrimaryContainer;
    case 'outline':
      return cs.outline;
    case 'tertiary':
      return cs.tertiary;
    case 'background':
      return cs.background;
    case 'onBackground':
      return cs.onBackground;
    case 'secondaryContainer':
      return cs.secondaryContainer;
    case 'error':
      return cs.error;
    case 'onError':
      return cs.onError;
    case 'onErrorContainer':
      return cs.onErrorContainer;
    case 'shadow':
      return cs.shadow;
    default:
      throw Exception('Invalid color key: $key');
  }
}

ThemeData createTheme(Brightness brightness, s) {
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorSchemeSeed: const Color(0xFF2C6C2F),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: s,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: s,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: s,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: s,
      ),
    ),
  );
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
