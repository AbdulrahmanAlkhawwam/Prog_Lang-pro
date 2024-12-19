import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import './colors.dart';
import './styles.dart';

class AppTheme {
  static ThemeData get lightTheme => _theme(lightColorScheme);

  static ThemeData get darkTheme => _theme(darkColorScheme);

  static _theme(ColorScheme colors) => ThemeData(
        canvasColor: colors.surfaceContainer,
        scaffoldBackgroundColor: colors.surface,
        colorScheme: colors,
        primaryColor: colors.primary,
        useMaterial3: true,
        tabBarTheme: _tabBarTheme(colors),
        textTheme: _textTheme(colors),
        textButtonTheme: _textButtonTheme(colors),
        inputDecorationTheme: _inputDecorationTheme(colors),
        bottomNavigationBarTheme: _bottomNavigationBarTheme(colors),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size(24, 24))),
        ),
      );

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colors) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colors.surfaceContainer,
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(appBor),
        borderSide: BorderSide(color: Colors.transparent, width: inputBor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(appBor),
        borderSide: BorderSide(color: Colors.transparent, width: inputBor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(appBor),
        borderSide: BorderSide(color: Colors.transparent, width: inputBor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(appBor),
        borderSide: BorderSide(color: Colors.transparent, width: inputBor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(appBor),
        borderSide: BorderSide(color: Colors.transparent, width: inputBor),
      ),
      labelStyle:
          _textTheme(colors).bodySmall?.copyWith(color: colors.onSurface),
      hintStyle: _textTheme(colors).bodySmall?.copyWith(color: colors.outline),
      errorStyle: _textTheme(colors).labelSmall?.copyWith(color: colors.error),
    );
  }

  static _bottomNavigationBarTheme(ColorScheme colors) {
    return BottomNavigationBarThemeData(
      elevation: 40,
      selectedItemColor: colors.primary,
      unselectedItemColor: colors.onSurface.withOpacity(0.5),
      showSelectedLabels: false,
      showUnselectedLabels: false,
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
        color: colors.onSurface,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 28 / 32,
        color: colors.onSurface,
      ),
      displaySmall: null,
      headlineLarge: GoogleFonts.poppins(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        height: 34 / 28,
        color: colors.onSurface,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        height: 30 / 24,
        color: colors.onSurface,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        height: 24 / 20,
        color: colors.onSurface,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 40 / 24,
        color: colors.onSurface,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 20 / 18,
        color: colors.onSurface,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 25 / 16,
        color: colors.onSurface,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 28 / 22,
        color: colors.onSurface,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 20 / 18,
        color: colors.onSurface,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 20 / 16,
        color: colors.onSurface,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 18 / 16,
        color: colors.onSurface,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 16 / 14,
        color: colors.onSurface,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 12,
        color: colors.onSurface,
      ),
    );
  }

  static _tabBarTheme(ColorScheme colors) {
    return TabBarTheme(
      dividerColor: colors.surfaceContainer,
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelColor: colors.primary,
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelColor: colors.outline,
    );
  }
}
