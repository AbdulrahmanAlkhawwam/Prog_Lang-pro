import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  /// PRIMARY COLOR
  primary: Color(0xFF4CAF50),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF81C784),
  onPrimaryContainer: Color(0xFF0A3D21),

  /// SECONDARY COLOR
  secondary: Color(0xFFFF8C42),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFB877),
  onSecondaryContainer: Color(0xFF4D2B13),

  /// TERTIARY COLOR
  tertiary: Color(0xFF00897B),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFF4AB29E),
  onTertiaryContainer: Color(0xFF00211C),

  /// ERROR COLOR
  error: Color(0xFFD32F2F),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFF8D7D7),
  onErrorContainer: Color(0xFF7A1414),

  /// SURFACE COLOR
  onSurface: Color(0xFF212121),
  surface: Color(0xFFF5F5F5),
  surfaceContainer: Color(0xFFFFFFFF),

  /// UTILS COLOR
  outline: Color(0xFFA5A5A5),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  /// PRIMARY COLOR
  primary: Color(0xFF4CAF50),
  onPrimary: Color(0xFF000000),
  primaryContainer: Color(0xFF0A3D21),
  onPrimaryContainer: Color(0xFF81C784),

  /// SECONDARY COLOR
  secondary: Color(0xFFFF8C42),
  onSecondary: Color(0xFF000000),
  secondaryContainer: Color(0xFF4D2B13),
  onSecondaryContainer: Color(0xFFFFB877),

  /// TERTIARY COLOR
  tertiary: Color(0xFF00897B),
  onTertiary: Color(0xFF000000),
  tertiaryContainer: Color(0xFF00211C),
  onTertiaryContainer: Color(0xFF4AB29E),

  /// ERROR COLOR
  error: Color(0xFFD32F2F),
  onError: Color(0xFF000000),
  errorContainer: Color(0xFF7A1414),
  onErrorContainer: Color(0xFFF8D7D7),

  /// SURFACE COLOR
  surface: Color(0xFF212121),
  onSurface: Color(0xFFF5F5F5),
  surfaceContainer: Color(0xFF191919),

  /// UTILS COLOR
  outline: Color(0xFF5C5C5C),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
);
