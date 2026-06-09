import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/constants/env_config.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/navigation_routes.dart';
import 'package:phicore/core/navigation/service/navigation_service.dart';
import 'package:phicore/core/services/connectivity/connectivity_service.dart';
import 'package:phicore/core/services/storage/storage_service.dart';
import 'package:phicore/core/theme/app_theme.dart';
import 'package:phicore/core/widgets/app_connectivity_banner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ortam ayarı
  EnvConfig.init(Environment.dev);

  // Servisler
  await StorageService.instance.init();
  await ConnectivityService.instance.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      initialRoute: NavigationConstants.splash,
      title: 'PhiCore',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      builder: (context, child) => AppConnectivityBanner(
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
