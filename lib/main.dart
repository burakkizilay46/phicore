import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/navigation_routes.dart';
import 'package:phicore/core/navigation/service/navigation_service.dart';
import 'package:phicore/core/theme/app_theme.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      initialRoute: NavigationConstants.splash,
      title: 'phicore',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
