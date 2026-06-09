import 'package:flutter/material.dart';

/// Ekran boyutu breakpoint'leri.
enum ScreenType { mobile, tablet, desktop }

/// Responsive yardımcı sınıfı.
/// Ekran boyutuna göre breakpoint belirler ve değer döner.
///
/// Kullanım:
/// ```dart
/// final padding = Responsive.value<double>(
///   context,
///   mobile: 16,
///   tablet: 24,
///   desktop: 32,
/// );
///
/// final type = Responsive.screenType(context);
/// ```
class Responsive {
  Responsive._();

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  /// Mevcut ekran tipini döner.
  static ScreenType screenType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < mobileBreakpoint) return ScreenType.mobile;
    if (width < tabletBreakpoint) return ScreenType.tablet;
    return ScreenType.desktop;
  }

  /// Ekran tipine göre değer döner.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    switch (screenType(context)) {
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.mobile:
        return mobile;
    }
  }

  /// Kısayollar
  static bool isMobile(BuildContext context) =>
      screenType(context) == ScreenType.mobile;

  static bool isTablet(BuildContext context) =>
      screenType(context) == ScreenType.tablet;

  static bool isDesktop(BuildContext context) =>
      screenType(context) == ScreenType.desktop;
}

/// Ekran tipine göre farklı widget render eden builder.
///
/// Kullanım:
/// ```dart
/// ResponsiveBuilder(
///   mobile: (context) => MobileLayout(),
///   tablet: (context) => TabletLayout(),
///   desktop: (context) => DesktopLayout(),
/// )
/// ```
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    switch (Responsive.screenType(context)) {
      case ScreenType.desktop:
        return (desktop ?? tablet ?? mobile)(context);
      case ScreenType.tablet:
        return (tablet ?? mobile)(context);
      case ScreenType.mobile:
        return mobile(context);
    }
  }
}

/// Responsive padding wrapper.
///
/// Kullanım:
/// ```dart
/// ResponsivePadding(
///   child: MyContent(),
/// )
/// ```
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
  });

  static const _defaultMobile = EdgeInsets.symmetric(horizontal: 16);
  static const _defaultTablet = EdgeInsets.symmetric(horizontal: 32);
  static const _defaultDesktop = EdgeInsets.symmetric(horizontal: 48);

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.value<EdgeInsets>(
      context,
      mobile: mobilePadding ?? _defaultMobile,
      tablet: tabletPadding ?? _defaultTablet,
      desktop: desktopPadding ?? _defaultDesktop,
    );

    return Padding(padding: padding, child: child);
  }
}
