import 'package:flutter/material.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_typography.dart';

/// PhiCore merkezi tema yapılandırması.
/// Minimal siyah-beyaz. Dark-first.
class AppTheme {
  AppTheme._();

  // ════════════════════════════════════════
  //  DARK TEMA (Ana tema)
  // ════════════════════════════════════════
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.white,
          onPrimary: AppColors.black,
          primaryContainer: AppColors.grey15,
          secondary: AppColors.grey70,
          onSecondary: AppColors.black,
          error: AppColors.error,
          surface: AppColors.surface,
          onSurface: AppColors.white,
          outline: AppColors.grey30,
        ),
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          displayLarge: AppTypography.displayLarge,
          displayMedium: AppTypography.displayMedium,
          displaySmall: AppTypography.displaySmall,
          headlineLarge: AppTypography.headingLarge,
          headlineMedium: AppTypography.headingMedium,
          headlineSmall: AppTypography.headingSmall,
          bodyLarge: AppTypography.bodyLarge,
          bodyMedium: AppTypography.bodyMedium,
          bodySmall: AppTypography.bodySmall,
          labelLarge: AppTypography.labelLarge,
          labelMedium: AppTypography.labelMedium,
          labelSmall: AppTypography.labelSmall,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: AppTypography.headingMedium,
          iconTheme: IconThemeData(color: AppColors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceLight,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.grey30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.grey30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.white, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          labelStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.grey50,
          ),
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.grey30,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.black,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTypography.labelLarge,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.white,
            side: const BorderSide(color: AppColors.grey30),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.grey90,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.surfaceLight,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.zero,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.grey15,
          thickness: 1,
          space: 1,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.grey50,
        ),
        iconTheme: const IconThemeData(color: AppColors.grey90),
      );

  // ════════════════════════════════════════
  //  LIGHT TEMA
  // ════════════════════════════════════════
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.white,
        colorScheme: const ColorScheme.light(
          primary: AppColors.black,
          onPrimary: AppColors.white,
          primaryContainer: AppColors.grey90,
          secondary: AppColors.grey50,
          onSecondary: AppColors.white,
          error: AppColors.error,
          surface: Color(0xFFF5F5F5),
          onSurface: AppColors.black,
          outline: Color(0xFFDDDDDD),
        ),
        fontFamily: 'Inter',
        textTheme: TextTheme(
          displayLarge: AppTypography.displayLarge.copyWith(
            color: AppColors.black,
          ),
          displayMedium: AppTypography.displayMedium.copyWith(
            color: AppColors.black,
          ),
          displaySmall: AppTypography.displaySmall.copyWith(
            color: AppColors.black,
          ),
          headlineLarge: AppTypography.headingLarge.copyWith(
            color: AppColors.black,
          ),
          headlineMedium: AppTypography.headingMedium.copyWith(
            color: AppColors.black,
          ),
          headlineSmall: AppTypography.headingSmall.copyWith(
            color: AppColors.black,
          ),
          bodyLarge: AppTypography.bodyLarge.copyWith(
            color: const Color(0xFF333333),
          ),
          bodyMedium: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFF333333),
          ),
          bodySmall: AppTypography.bodySmall.copyWith(
            color: const Color(0xFF666666),
          ),
          labelLarge: AppTypography.labelLarge.copyWith(
            color: AppColors.white,
          ),
          labelMedium: AppTypography.labelMedium.copyWith(
            color: AppColors.white,
          ),
          labelSmall: AppTypography.labelSmall.copyWith(
            color: const Color(0xFF666666),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: AppTypography.headingMedium.copyWith(
            color: AppColors.black,
          ),
          iconTheme: const IconThemeData(color: AppColors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.black, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          labelStyle: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFF888888),
          ),
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFFBBBBBB),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.black,
            foregroundColor: AppColors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTypography.labelLarge,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.black,
            side: const BorderSide(color: Color(0xFFDDDDDD)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.black,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFEEEEEE)),
          ),
          margin: EdgeInsets.zero,
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFFEEEEEE),
          thickness: 1,
          space: 1,
        ),
      );
}
