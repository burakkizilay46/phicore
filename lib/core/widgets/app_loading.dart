import 'package:flutter/material.dart';
import 'package:phicore/core/theme/app_colors.dart';

/// Minimal loading indicator.
///
/// Kullanım:
/// ```dart
/// AppLoading()                        // Beyaz çizgi
/// AppLoading(size: 16)                // Küçük
/// AppLoading.overlay()                // Tam ekran overlay
/// ```
class AppLoading extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const AppLoading({
    super.key,
    this.size = 24,
    this.strokeWidth = 2,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  /// Sayfa üzerine yarı saydam overlay olarak gösterir.
  static Widget overlay({String? message}) {
    return _LoadingOverlay(message: message);
  }
}

class _LoadingOverlay extends StatelessWidget {
  final String? message;
  const _LoadingOverlay({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black.withValues(alpha: 0.5),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.grey30, width: 0.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppLoading(),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
