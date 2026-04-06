import 'package:flutter/material.dart';

class FontFamily {
  static const spaceGrotesk = "SpaceGrotesk";  // Headings
  static const manrope = "Manrope";            // Body
}

class AppTextStyles {
  static const displayLarge = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    fontFamily: FontFamily.spaceGrotesk,
  );

  static const displayMedium = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    fontFamily: FontFamily.spaceGrotesk,
  );

  static const displaySmall = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    fontFamily: FontFamily.spaceGrotesk,
  );

  static const headlineLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: FontFamily.spaceGrotesk,
  );

  static const headlineMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.spaceGrotesk,
  );

  static const headlineSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.spaceGrotesk,
  );

  static const titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.manrope,
  );

  static const titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: FontFamily.manrope,
  );

  static const titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: FontFamily.manrope,
  );

  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: FontFamily.manrope,
  );

  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: FontFamily.manrope,
  );

  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: FontFamily.manrope,
  );

  static const labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.manrope,
  );

  static const labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: FontFamily.manrope,
  );

  static const labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    fontFamily: FontFamily.manrope,
  );

  static const splashAppName = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    fontFamily: FontFamily.spaceGrotesk,
    letterSpacing: -1.0,
  );

  static const splashTagline = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: FontFamily.spaceGrotesk,
    letterSpacing: 4.0,
    color: Color(0xFF8A9BB0),
  );

  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: FontFamily.manrope,
  );
}