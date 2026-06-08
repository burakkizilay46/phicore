import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_radius.dart';
import 'package:phicore/core/theme/app_shadows.dart';
import 'package:phicore/core/theme/app_typography.dart';

/// TextField varyantları.
enum AppTextFieldVariant { outlined, filled, glass }

/// PhiCore base text field widget.
///
/// Kullanım:
/// ```dart
/// AppTextField(label: 'Email', prefixIcon: Icon(Icons.email))
/// AppTextField.filled(label: 'Şifre', obscureText: true)
/// AppTextField.glass(label: 'Ara...', prefixIcon: Icon(Icons.search))
/// ```
class AppTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? helperText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int? maxLength;
  final bool enabled;
  final bool autofocus;
  final bool readOnly;
  final FocusNode? focusNode;
  final AppTextFieldVariant variant;
  final List<TextInputFormatter>? inputFormatters;
  final BorderRadius? borderRadius;

  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.validator,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.autofocus = false,
    this.readOnly = false,
    this.focusNode,
    this.variant = AppTextFieldVariant.outlined,
    this.inputFormatters,
    this.borderRadius,
  });

  /// Filled varyant shortcut.
  const AppTextField.filled({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.validator,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.autofocus = false,
    this.readOnly = false,
    this.focusNode,
    this.inputFormatters,
    this.borderRadius,
  }) : variant = AppTextFieldVariant.filled;

  /// Glass varyant shortcut.
  const AppTextField.glass({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.validator,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.autofocus = false,
    this.readOnly = false,
    this.focusNode,
    this.inputFormatters,
    this.borderRadius,
  }) : variant = AppTextFieldVariant.glass;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  BorderRadius get _borderRadius =>
      widget.borderRadius ?? AppRadius.mdBorder;

  @override
  Widget build(BuildContext context) {
    switch (widget.variant) {
      case AppTextFieldVariant.outlined:
        return _buildOutlined(context);
      case AppTextFieldVariant.filled:
        return _buildFilled(context);
      case AppTextFieldVariant.glass:
        return _buildGlass(context);
    }
  }

  // ── Outlined ──
  Widget _buildOutlined(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        boxShadow: _isFocused ? AppShadows.subtle : null,
      ),
      child: _buildTextFormField(context),
    );
  }

  // ── Filled ──
  Widget _buildFilled(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.glassDark
            : AppColors.grey15,
        borderRadius: _borderRadius,
        boxShadow: _isFocused ? AppShadows.subtle : null,
        border: Border.all(
          color: _isFocused
              ? theme.colorScheme.primary.withOpacity(0.5)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: _buildTextFormField(
        context,
        filled: true,
        fillColor: Colors.transparent,
        borderStyle: InputBorder.none,
      ),
    );
  }

  // ── Glass ──
  Widget _buildGlass(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: AppColors.glassGradient,
            borderRadius: _borderRadius,
            border: Border.all(
              color: _isFocused
                  ? AppColors.glassBorder
                  : AppColors.glassBorder.withOpacity(0.5),
              width: 1,
            ),
            boxShadow: AppShadows.glass,
          ),
          child: _buildTextFormField(
            context,
            filled: true,
            fillColor: Colors.transparent,
            borderStyle: InputBorder.none,
            textColor: AppColors.white,
            hintColor: AppColors.white.withOpacity(0.6),
            labelColor: AppColors.white.withOpacity(0.8),
            cursorColor: AppColors.white,
          ),
        ),
      ),
    );
  }

  // ── Ortak TextFormField builder ──
  Widget _buildTextFormField(
    BuildContext context, {
    bool filled = false,
    Color? fillColor,
    InputBorder? borderStyle,
    Color? textColor,
    Color? hintColor,
    Color? labelColor,
    Color? cursorColor,
  }) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      obscureText: widget.obscureText && !_obscureVisible,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      inputFormatters: widget.inputFormatters,
      cursorColor: cursorColor ?? theme.colorScheme.primary,
      style: AppTypography.bodyLarge.copyWith(
        color: textColor ?? theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        helperText: widget.helperText,
        filled: filled || borderStyle == null,
        fillColor: fillColor,
        prefixIcon: widget.prefixIcon != null
            ? IconTheme(
                data: IconThemeData(
                  color: _isFocused
                      ? (labelColor ?? theme.colorScheme.primary)
                      : (hintColor ?? AppColors.grey50),
                  size: 20,
                ),
                child: widget.prefixIcon!,
              )
            : null,
        suffixIcon: widget.obscureText
            ? _buildObscureToggle(hintColor)
            : widget.suffixIcon != null
                ? IconTheme(
                    data: IconThemeData(
                      color: hintColor ?? AppColors.grey50,
                      size: 20,
                    ),
                    child: widget.suffixIcon!,
                  )
                : null,
        labelStyle: AppTypography.bodyMedium.copyWith(
          color: _isFocused
              ? (labelColor ?? theme.colorScheme.primary)
              : (labelColor ?? AppColors.grey50),
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: hintColor ?? AppColors.grey50,
        ),
        helperStyle: AppTypography.caption,
        errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: borderStyle,
        enabledBorder: borderStyle,
        focusedBorder: borderStyle,
        errorBorder: borderStyle,
        focusedErrorBorder: borderStyle,
        disabledBorder: borderStyle,
        counterText: '',
      ),
    );
  }

  // ── Şifre göster/gizle toggle ──
  Widget _buildObscureToggle(Color? iconColor) {
    return GestureDetector(
      onTap: () => setState(() => _obscureVisible = !_obscureVisible),
      child: Icon(
        _obscureVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
        color: iconColor ?? AppColors.grey50,
        size: 20,
      ),
    );
  }
}
