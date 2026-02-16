import 'package:flutter/material.dart';
import 'package:phicore/core/navigation/service/INavigationService.dart';

class NavigationService implements INavigationService {
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  bool removeOldRoutes(Route<dynamic> route) => false;

  @override
  Future<void> navigateToPage({required String path, Object? data}) async {
    await navigatorKey.currentState!.pushNamed(path, arguments: data);
  }

  @override
  Future<void> navigateToPageClear({required String path, Object? data}) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(
      path,
      removeOldRoutes,
      arguments: data,
    );
  }

  @override
  Future<void> pop() async => await navigatorKey.currentState!.maybePop();
}
