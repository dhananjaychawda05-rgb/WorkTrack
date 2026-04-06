import 'package:flutter/material.dart';

class AppColors {
  // ─── PRIMARY ──────────────────────────────────────────────────
  static const Color primary     = Color(0xFF00C97A);
  static const Color primaryDark = Color(0xFF009958);
  static const Color primaryGlow = Color(0x2600C97A);
  static const Color accent      = Color(0xFF00C97A);
  static const Color success     = Color(0xFF00C97A);

  // ─── SECONDARY ────────────────────────────────────────────────
  static const Color secondary      = Color(0xFF131F2E);
  static const Color darkSurface    = Color(0xFF131F2E);
  static const Color surface        = Color(0xFF131F2E);
  static const Color surfaceAlt     = Color(0xFF1A2E42);
  static const Color cardDark       = Color(0xFF0F1E2E);
  static const Color background     = Color(0xFF0D1B2A);
  static const Color darkBackground = Color(0xFF0D1B2A);

  // ─── TERTIARY ─────────────────────────────────────────────────
  static const Color tertiary    = Color(0xFF4A6070);
  static const Color border      = Color(0xFF1E3A2E);
  static const Color borderLight = Color(0xFF243545);
  static const Color textHint    = Color(0xFF4A6070);
  static const Color info        = Color(0xFF29B6F6);

  // ─── NEUTRAL ──────────────────────────────────────────────────
  static const Color neutralDark = Color(0xFF131B24);
  static const Color textPrimary   = Color(0xFFFFFFFF);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  
  static const Color textSecondary = Color(0xFF8A9BB0);
  static const Color darkTextSecondary = Color(0xFF8A9BB0);

  // Light theme overrides (Neutrals)
  static const Color lightBackground  = Color(0xFFF4F6FA);
  static const Color backgroundLight  = Color(0xFFF4F6FA);
  static const Color lightSurface     = Color(0xFFFFFFFF);
  static const Color surfaceLight     = Color(0xFFFFFFFF);
  
  // Text in light theme is heavily contrasted
  static const Color lightTextPrimary = Color(0xFF0D1B2A);
  static const Color textPrimaryLight = Color(0xFF0D1B2A);
  static const Color lightTextSecondary = Color(0xFF8A9BB0);

  // ─── UTILITY / STATUS ─────────────────────────────────────────
  static const Color transparent = Colors.transparent;
  static const Color error       = Color(0xFFFF4D4D);
  static const Color warning     = Color(0xFFFFA726);
}
