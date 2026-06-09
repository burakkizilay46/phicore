import 'package:flutter/material.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_typography.dart';

/// Snackbar tipleri.
enum AppSnackbarType { info, success, warning, error }

/// Minimal themed snackbar.
///
/// Kullanım:
/// ```dart
/// AppSnackbar.show(context, message: 'Kaydedildi', type: AppSnackbarType.success);
/// AppSnackbar.error(context, message: 'Bir hata oluştu');
/// ```
class AppSnackbar {
  AppSnackbar._();

  static void show(
    BuildContext context, {
    required String message,
    AppSnackbarType type = AppSnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final color = _color(type);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(_icon(type), color: color, size: 18),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.surfaceElevated,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: color.withValues(alpha: 0.3), width: 1),
          ),
          margin: const EdgeInsets.all(16),
          duration: duration,
          action: action,
        ),
      );
  }

  static void success(BuildContext context, {required String message}) =>
      show(context, message: message, type: AppSnackbarType.success);

  static void error(BuildContext context, {required String message}) =>
      show(context, message: message, type: AppSnackbarType.error);

  static void warning(BuildContext context, {required String message}) =>
      show(context, message: message, type: AppSnackbarType.warning);

  static Color _color(AppSnackbarType type) {
    switch (type) {
      case AppSnackbarType.info:
        return AppColors.info;
      case AppSnackbarType.success:
        return AppColors.success;
      case AppSnackbarType.warning:
        return AppColors.warning;
      case AppSnackbarType.error:
        return AppColors.error;
    }
  }

  static IconData _icon(AppSnackbarType type) {
    switch (type) {
      case AppSnackbarType.info:
        return Icons.info_outline_rounded;
      case AppSnackbarType.success:
        return Icons.check_circle_outline_rounded;
      case AppSnackbarType.warning:
        return Icons.warning_amber_rounded;
      case AppSnackbarType.error:
        return Icons.error_outline_rounded;
    }
  }
}
