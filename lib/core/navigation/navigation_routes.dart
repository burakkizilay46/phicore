import 'package:flutter/material.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/not_found_navigation.dart';
import 'package:phicore/features/auth/sign_in/view/auth_view.dart';
import 'package:phicore/features/splash/view/splash_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.splash:
        return normalNavigate(const SplashView());
      case NavigationConstants.sign_in:
        return normalNavigate(const SignInView());
      case NavigationConstants.register:
        return normalNavigate(const SignInView());
      default:
        return normalNavigate(const NotFoundNavigation());
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);
}
