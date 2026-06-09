import 'package:flutter/material.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_radius.dart';
import 'package:phicore/core/theme/app_spacing.dart';
import 'package:phicore/core/theme/app_typography.dart';
import 'package:phicore/core/widgets/app_button.dart';

/// Minimal dialog.
///
/// Kullanım:
/// ```dart
/// AppDialog.show(
///   context,
///   title: 'Çıkış Yap',
///   message: 'Çıkış yapmak istediğinize emin misiniz?',
///   confirmText: 'Çıkış',
///   onConfirm: () => authService.signOut(),
/// );
/// ```
class AppDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final bool isDestructive;

  const AppDialog({
    super.key,
    this.title,
    this.message,
    this.content,
    this.confirmText = 'Tamam',
    this.cancelText = 'İptal',
    this.onConfirm,
    this.isDestructive = false,
  });

  /// Dialog'u gösterir.
  static Future<bool?> show(
    BuildContext context, {
    String? title,
    String? message,
    Widget? content,
    String confirmText = 'Tamam',
    String cancelText = 'İptal',
    VoidCallback? onConfirm,
    bool isDestructive = false,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: AppColors.black.withValues(alpha: 0.6),
      builder: (_) => AppDialog(
        title: title,
        message: message,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        isDestructive: isDestructive,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: isDark ? AppColors.surfaceLight : AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.xlBorder),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title!,
                style: AppTypography.headingMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            if (title != null && (message != null || content != null))
              AppSpacing.gapMd,
            if (message != null)
              Text(
                message!,
                style: AppTypography.bodyMedium.copyWith(
                  color: isDark ? AppColors.grey70 : AppColors.grey50,
                ),
              ),
            ?content,
            AppSpacing.gapXl,
            Row(
              children: [
                Expanded(
                  child: AppButton.outlined(
                    text: cancelText,
                    size: AppButtonSize.sm,
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                ),
                AppSpacing.gapHorizontalMd,
                Expanded(
                  child: AppButton(
                    text: confirmText,
                    size: AppButtonSize.sm,
                    color: isDestructive ? AppColors.error : null,
                    onTap: () {
                      onConfirm?.call();
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
