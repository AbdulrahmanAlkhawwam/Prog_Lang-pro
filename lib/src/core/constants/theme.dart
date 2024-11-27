import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './colors.dart';
import './styles.dart';

class AppTheme {
  static ThemeData get lightTheme => _theme(lightColorScheme);

  static ThemeData get darkTheme => _theme(darkColorScheme);

  static _theme(ColorScheme colors) => ThemeData(
        scaffoldBackgroundColor: colors.surface,
        colorScheme: colors,
        primaryColor: colors.primary,
        useMaterial3: true,
        textTheme: _textTheme(colors),
        textButtonTheme: _textButtonTheme(colors),
        inputDecorationTheme: _inputDecorationTheme(colors),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size(24, 24))),
        ),
      );

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colors) {
    return InputDecorationTheme(
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(appBor),
        borderSide: BorderSide(color: Colors.transparent, width: inputBor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circle),
        borderSide: BorderSide(color: Colors.transparent, width: inputBor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circle),
        borderSide: BorderSide(color: Colors.transparent, width: inputBor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circle),
        borderSide: BorderSide(color: Colors.transparent, width: inputBor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circle),
        borderSide: BorderSide(color: Colors.transparent, width: inputBor),
      ),
      labelStyle:
          _textTheme(colors).bodySmall?.copyWith(color: colors.onSurface),
      hintStyle:
          _textTheme(colors).bodySmall?.copyWith(color: colors.onSurface),
      errorStyle: _textTheme(colors).bodySmall?.copyWith(color: colors.error),
    );
  }

  static TextButtonThemeData _textButtonTheme(ColorScheme colors) {
    return TextButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        shape: const WidgetStatePropertyAll(StadiumBorder()),
        textStyle: WidgetStatePropertyAll(_textTheme(colors).bodySmall),
      ),
    );
  }

  static TextTheme _textTheme(ColorScheme colors) {
    return TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 42,
        fontWeight: FontWeight.w400,
        height: 46 / 40,
        color: colors.onTertiaryContainer,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 28 / 32,
        color: colors.onTertiaryContainer,
      ),
      displaySmall: null,
      headlineLarge: GoogleFonts.poppins(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        height: 34 / 28,
        color: colors.onTertiaryContainer,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        height: 30 / 24,
        color: colors.onTertiaryContainer,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        height: 24 / 20,
        color: colors.onTertiaryContainer,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 40 / 24,
        color: colors.onTertiaryContainer,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 20 / 18,
        color: colors.onTertiaryContainer,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 25 / 16,
        color: colors.onTertiaryContainer,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 28 / 22,
        color: colors.onTertiaryContainer,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 20 / 18,
        color: colors.onTertiaryContainer,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 20 / 16,
        color: colors.onTertiaryContainer,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 18 / 16,
        color: colors.onTertiaryContainer,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 16 / 14,
        color: colors.onTertiaryContainer,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 12,
        color: colors.onTertiaryContainer,
      ),
    );
  }
}
