import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_radius.dart';
import 'package:phicore/core/theme/app_shadows.dart';
import 'package:phicore/core/theme/app_typography.dart';

/// Button varyantları.
enum AppButtonVariant { filled, outlined, ghost, glass, gradient }

/// Button boyutları.
enum AppButtonSize { sm, md, lg }

/// PhiCore base button widget.
///
/// Kullanım:
/// ```dart
/// AppButton(text: 'Giriş Yap', onTap: () {})
/// AppButton.outlined(text: 'İptal', onTap: () {})
/// AppButton.glass(text: 'Devam', onTap: () {})
/// AppButton.gradient(text: 'Başla', onTap: () {}, gradient: AppColors.primaryGradient)
/// ```
class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isDisabled;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? color;
  final LinearGradient? gradient;
  final bool expand;
  final BorderRadius? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
    this.variant = AppButtonVariant.filled,
    this.size = AppButtonSize.md,
    this.prefixIcon,
    this.suffixIcon,
    this.color,
    this.gradient,
    this.expand = true,
    this.borderRadius,
  });

  /// Outlined varyant shortcut.
  const AppButton.outlined({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = AppButtonSize.md,
    this.prefixIcon,
    this.suffixIcon,
    this.color,
    this.expand = true,
    this.borderRadius,
  })  : variant = AppButtonVariant.outlined,
        gradient = null;

  /// Ghost (text-only) varyant shortcut.
  const AppButton.ghost({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = AppButtonSize.md,
    this.prefixIcon,
    this.suffixIcon,
    this.color,
    this.expand = false,
    this.borderRadius,
  })  : variant = AppButtonVariant.ghost,
        gradient = null;

  /// Glassmorphism varyant shortcut.
  const AppButton.glass({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = AppButtonSize.md,
    this.prefixIcon,
    this.suffixIcon,
    this.color,
    this.expand = true,
    this.borderRadius,
  })  : variant = AppButtonVariant.glass,
        gradient = null;

  /// Gradient varyant shortcut.
  const AppButton.gradient({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = AppButtonSize.md,
    this.prefixIcon,
    this.suffixIcon,
    this.gradient,
    this.expand = true,
    this.borderRadius,
  })  : variant = AppButtonVariant.gradient,
        color = null;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  bool get _isEnabled =>
      !widget.isLoading && !widget.isDisabled && widget.onTap != null;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _height {
    switch (widget.size) {
      case AppButtonSize.sm:
        return 40;
      case AppButtonSize.md:
        return 50;
      case AppButtonSize.lg:
        return 58;
    }
  }

  TextStyle get _textStyle {
    switch (widget.size) {
      case AppButtonSize.sm:
        return AppTypography.labelSmall;
      case AppButtonSize.md:
        return AppTypography.labelMedium;
      case AppButtonSize.lg:
        return AppTypography.labelLarge;
    }
  }

  double get _loaderSize {
    switch (widget.size) {
      case AppButtonSize.sm:
        return 16;
      case AppButtonSize.md:
        return 20;
      case AppButtonSize.lg:
        return 22;
    }
  }

  BorderRadius get _borderRadius =>
      widget.borderRadius ?? AppRadius.mdBorder;

  Color get _resolvedColor =>
      widget.color ?? Theme.of(context).colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (widget.variant) {
      case AppButtonVariant.filled:
        return _buildFilled();
      case AppButtonVariant.outlined:
        return _buildOutlined();
      case AppButtonVariant.ghost:
        return _buildGhost();
      case AppButtonVariant.glass:
        return _buildGlass();
      case AppButtonVariant.gradient:
        return _buildGradient();
    }
  }

  // ── Filled ──
  Widget _buildFilled() {
    return _wrapGesture(
      AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _height,
        width: widget.expand ? double.infinity : null,
        decoration: BoxDecoration(
          color: _isEnabled
              ? _resolvedColor
              : _resolvedColor.withOpacity(0.4),
          borderRadius: _borderRadius,
          boxShadow: _isEnabled ? AppShadows.soft : null,
        ),
        child: _buildContent(AppColors.white),
      ),
    );
  }

  // ── Outlined ──
  Widget _buildOutlined() {
    return _wrapGesture(
      AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _height,
        width: widget.expand ? double.infinity : null,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: _borderRadius,
          border: Border.all(
            color: _isEnabled
                ? _resolvedColor
                : _resolvedColor.withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: _buildContent(_resolvedColor),
      ),
    );
  }

  // ── Ghost ──
  Widget _buildGhost() {
    return _wrapGesture(
      SizedBox(
        height: _height,
        width: widget.expand ? double.infinity : null,
        child: _buildContent(_resolvedColor),
      ),
    );
  }

  // ── Glass ──
  Widget _buildGlass() {
    return _wrapGesture(
      ClipRRect(
        borderRadius: _borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: _height,
            width: widget.expand ? double.infinity : null,
            decoration: BoxDecoration(
              gradient: AppColors.glassGradient,
              borderRadius: _borderRadius,
              border: Border.all(
                color: AppColors.glassBorder,
                width: 1,
              ),
              boxShadow: AppShadows.glass,
            ),
            child: _buildContent(AppColors.white),
          ),
        ),
      ),
    );
  }

  // ── Gradient ──
  Widget _buildGradient() {
    final grad = widget.gradient ?? AppColors.primaryGradient;
    return _wrapGesture(
      AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _height,
        width: widget.expand ? double.infinity : null,
        decoration: BoxDecoration(
          gradient: _isEnabled ? grad : null,
          color: _isEnabled ? null : AppColors.grey50.withOpacity(0.3),
          borderRadius: _borderRadius,
          boxShadow: _isEnabled ? AppShadows.primaryGlow : null,
        ),
        child: _buildContent(AppColors.white),
      ),
    );
  }

  // ── İçerik (text + icon + loader) ──
  Widget _buildContent(Color foreground) {
    final color = _isEnabled ? foreground : foreground.withOpacity(0.6);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: widget.isLoading
              ? SizedBox(
                  key: const ValueKey('loader'),
                  width: _loaderSize,
                  height: _loaderSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color,
                  ),
                )
              : Row(
                  key: const ValueKey('content'),
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.prefixIcon != null) ...[
                      IconTheme(
                        data: IconThemeData(color: color, size: _loaderSize),
                        child: widget.prefixIcon!,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text,
                      style: _textStyle.copyWith(color: color),
                    ),
                    if (widget.suffixIcon != null) ...[
                      const SizedBox(width: 8),
                      IconTheme(
                        data: IconThemeData(color: color, size: _loaderSize),
                        child: widget.suffixIcon!,
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }

  // ── Gesture wrapper ──
  Widget _wrapGesture(Widget child) {
    return GestureDetector(
      onTapDown: _isEnabled ? (_) => _controller.forward() : null,
      onTapUp: _isEnabled
          ? (_) {
              _controller.reverse();
              widget.onTap?.call();
            }
          : null,
      onTapCancel: _isEnabled ? () => _controller.reverse() : null,
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
