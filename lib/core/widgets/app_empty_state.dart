import 'package:flutter/material.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_spacing.dart';
import 'package:phicore/core/widgets/app_button.dart';

/// Boş veri, hata, bağlantı yok gibi durumları gösteren placeholder widget.
///
/// Kullanım:
/// ```dart
/// AppEmptyState(
///   icon: Icons.inbox_outlined,
///   title: 'Henüz veri yok',
///   description: 'Yeni içerik eklediğinizde burada görünür.',
/// )
///
/// AppEmptyState.error(
///   onRetry: () => ref.refresh(myProvider),
/// )
///
/// AppEmptyState.noConnection(
///   onRetry: () => ref.refresh(myProvider),
/// )
/// ```
class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;
  final String? actionText;
  final VoidCallback? onAction;

  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.actionText,
    this.onAction,
  });

  /// Genel hata durumu.
  factory AppEmptyState.error({
    String title = 'Bir hata oluştu',
    String description = 'Lütfen tekrar deneyin.',
    String actionText = 'Tekrar Dene',
    VoidCallback? onRetry,
  }) {
    return AppEmptyState(
      icon: Icons.error_outline_rounded,
      title: title,
      description: description,
      actionText: actionText,
      onAction: onRetry,
    );
  }

  /// İnternet bağlantısı yok durumu.
  factory AppEmptyState.noConnection({
    String title = 'Bağlantı yok',
    String description = 'İnternet bağlantınızı kontrol edip tekrar deneyin.',
    String actionText = 'Tekrar Dene',
    VoidCallback? onRetry,
  }) {
    return AppEmptyState(
      icon: Icons.wifi_off_rounded,
      title: title,
      description: description,
      actionText: actionText,
      onAction: onRetry,
    );
  }

  /// Arama sonucu bulunamadı durumu.
  factory AppEmptyState.noResults({
    String title = 'Sonuç bulunamadı',
    String description = 'Farklı anahtar kelimeler ile tekrar deneyin.',
  }) {
    return AppEmptyState(
      icon: Icons.search_off_rounded,
      title: title,
      description: description,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: AppSpacing.paddingXl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // İkon container
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceLight : const Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: AppColors.grey50,
              ),
            ),
            AppSpacing.gapXl,

            // Başlık
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),

            // Açıklama
            if (description != null) ...[
              AppSpacing.gapSm,
              Text(
                description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.grey50,
                    ),
                textAlign: TextAlign.center,
              ),
            ],

            // Aksiyon butonu
            if (onAction != null && actionText != null) ...[
              AppSpacing.gapXl,
              AppButton.outlined(
                onTap: onAction,
                text: actionText!,
                expand: false,
                size: AppButtonSize.sm,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
