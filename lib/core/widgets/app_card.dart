import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_radius.dart';
import 'package:phicore/core/theme/app_shadows.dart';

/// Card varyantları.
enum AppCardVariant { flat, elevated, outlined, glass }

/// PhiCore base card widget.
///
/// Kullanım:
/// ```dart
/// AppCard(child: Text('İçerik'))
/// AppCard.outlined(child: ListTile(...))
/// AppCard.glass(child: ...)
/// ```
class AppCard extends StatelessWidget {
  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? color;

  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.flat,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.color,
  });

  const AppCard.elevated({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.color,
  }) : variant = AppCardVariant.elevated;

  const AppCard.outlined({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.color,
  }) : variant = AppCardVariant.outlined;

  const AppCard.glass({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.color,
  }) : variant = AppCardVariant.glass;

  BorderRadius get _borderRadius => borderRadius ?? AppRadius.lgBorder;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget card;

    switch (variant) {
      case AppCardVariant.flat:
        card = Container(
          decoration: BoxDecoration(
            color: color ?? (isDark ? AppColors.surfaceLight : Colors.white),
            borderRadius: _borderRadius,
          ),
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        );
        break;

      case AppCardVariant.elevated:
        card = Container(
          decoration: BoxDecoration(
            color: color ?? (isDark ? AppColors.surfaceLight : Colors.white),
            borderRadius: _borderRadius,
            boxShadow: AppShadows.soft,
          ),
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        );
        break;

      case AppCardVariant.outlined:
        card = Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: _borderRadius,
            border: Border.all(
              color: isDark ? AppColors.grey30 : const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        );
        break;

      case AppCardVariant.glass:
        card = ClipRRect(
          borderRadius: _borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.glassGradient,
                borderRadius: _borderRadius,
                border: Border.all(color: AppColors.glassBorder, width: 1),
                boxShadow: AppShadows.glass,
              ),
              padding: padding ?? const EdgeInsets.all(16),
              child: child,
            ),
          ),
        );
        break;
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: card,
      );
    }

    return card;
  }
}
