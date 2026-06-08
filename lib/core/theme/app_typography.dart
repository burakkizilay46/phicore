import 'package:flutter/material.dart';
import 'package:phicore/core/theme/app_colors.dart';

/// PhiCore tipografi sistemi.
/// Minimal siyah-beyaz tema: varsayılan text renkleri beyaz tonlarında (dark-first).
class AppTypography {
  AppTypography._();

  static const String _fontFamily = 'Inter';

  // ── Display ──
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppColors.white,
    height: 1.2,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: AppColors.white,
    height: 1.25,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.3,
  );

  // ── Heading ──
  static const TextStyle headingLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.35,
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.4,
  );

  static const TextStyle headingSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.4,
  );

  // ── Body ──
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.grey90,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey90,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.grey50,
    height: 1.5,
  );

  // ── Label (button, chip, badge) ──
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    color: AppColors.black,
    height: 1.2,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    color: AppColors.black,
    height: 1.2,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
    color: AppColors.grey50,
    height: 1.2,
  );

  // ── Caption ──
  static const TextStyle caption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.grey50,
    height: 1.4,
  );
}
