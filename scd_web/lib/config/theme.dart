import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- COLOR PALETTE (as per instructions.txt) ---
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color primary = Color(0xFFD4AF37); // Gold accent
  static const Color onBackground = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFFE0E0E0);
  static const Color onPrimary = Color(0xFF000000);

  // --- LEGACY COLORS (can be phased out) ---
  static const Color primaryBlack = Color(0xFF121212);
  static const Color primaryWhite = Colors.white;
  static const Color accentGold = Color(0xFFD4AF37);

  // --- TYPOGRAPHY (as per instructions.txt) ---
  static final TextTheme _textTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      color: onBackground,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: onBackground,
    ),
    titleLarge: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: onBackground,
    ),
    bodyLarge: GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: onSurface,
    ),
    bodyMedium: GoogleFonts.lato(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: onSurface,
    ),
    labelLarge: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: onPrimary,
    ),
  );

  // --- THEME DATA ---
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      cardColor: surface,
      textTheme: _textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        iconTheme: IconThemeData(color: onBackground),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          textStyle: _textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: primary,
        background: background,
        surface: surface,
      ),
    );
  }

  // A light theme can be defined here later if needed
  static ThemeData get lightTheme => darkTheme; // For now, default to dark
}
