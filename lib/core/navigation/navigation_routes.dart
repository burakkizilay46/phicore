import 'package:flutter/material.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/not_found_navigation.dart';
import 'package:phicore/features/auth/forgot_password/view/forgot_password_view.dart';
import 'package:phicore/features/auth/register/view/register_view.dart';
import 'package:phicore/features/auth/sign_in/view/auth_view.dart';
import 'package:phicore/features/home/view/home_view.dart';
import 'package:phicore/features/onboarding/view/onboarding_view.dart';
import 'package:phicore/features/splash/view/splash_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.splash:
        return normalNavigate(const SplashView());
      case NavigationConstants.onboarding:
        return normalNavigate(const OnboardingView());
      case NavigationConstants.signIn:
        return normalNavigate(const SignInView());
      case NavigationConstants.register:
        return normalNavigate(const RegisterView());
      case NavigationConstants.forgotPassword:
        return normalNavigate(const ForgotPasswordView());
      case NavigationConstants.home:
        return normalNavigate(const HomeView());
      default:
        return normalNavigate(const NotFoundNavigation());
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);
}
