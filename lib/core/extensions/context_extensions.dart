import 'package:flutter/material.dart';

/// BuildContext üzerinden hızlı erişim extension'ları.
extension ContextExtensions on BuildContext {
  // ── Theme ──
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  bool get isDark => theme.brightness == Brightness.dark;

  // ── MediaQuery ──
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => mediaQuery.padding;
  double get topPadding => padding.top;
  double get bottomPadding => padding.bottom;
  double get keyboardHeight => mediaQuery.viewInsets.bottom;
  bool get isKeyboardOpen => keyboardHeight > 0;

  // ── Navigation ──
  NavigatorState get navigator => Navigator.of(this);
  void pop<T>([T? result]) => navigator.pop(result);
  Future<T?> pushNamed<T>(String route, {Object? arguments}) =>
      navigator.pushNamed<T>(route, arguments: arguments);
  Future<T?> pushReplacementNamed<T, TO>(String route, {Object? arguments}) =>
      navigator.pushReplacementNamed<T, TO>(route, arguments: arguments);

  // ── Focus ──
  void unfocus() => FocusScope.of(this).unfocus();

  // ── Snackbar ──
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : null,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
