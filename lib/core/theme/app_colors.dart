import 'package:flutter/material.dart';

/// PhiCore renk paleti.
/// Minimal siyah-beyaz. Temiz, kontrast, net.
class AppColors {
  AppColors._();

  // ── Primary (Beyaz) ──
  static const Color primary = Color(0xFFFFFFFF);
  static const Color primaryMuted = Color(0xFFCCCCCC);

  // ── Background / Surface ──
  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF111111);
  static const Color surfaceLight = Color(0xFF1A1A1A);
  static const Color surfaceElevated = Color(0xFF222222);

  // ── Neutral ──
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey90 = Color(0xFFE5E5E5);
  static const Color grey70 = Color(0xFFB3B3B3);
  static const Color grey50 = Color(0xFF808080);
  static const Color grey30 = Color(0xFF4D4D4D);
  static const Color grey15 = Color(0xFF262626);
  static const Color black = Color(0xFF000000);

  // ── Semantic ──
  static const Color success = Color(0xFF34D399);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF60A5FA);

  // ── Glass ──
  static const Color glassWhite = Color(0x15FFFFFF);
  static const Color glassBorder = Color(0x25FFFFFF);
  static const Color glassDark = Color(0x40000000);

  // ── Gradient'ler ──
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFAAAAAA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFF1A1A1A), Color(0xFF0A0A0A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0x18FFFFFF), Color(0x08FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
