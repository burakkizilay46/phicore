import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/constants/env_config.dart';
import 'package:phicore/core/services/analytics/analytics_service.dart';
import 'package:phicore/core/services/app_check/app_check_service.dart';
import 'package:phicore/core/utils/app_logger.dart';
import 'package:phicore/firebase_options.dart';
import 'package:phicore/core/localization/app_localizations.dart';
import 'package:phicore/core/localization/locale_provider.dart';
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

  // Firebase (yalnızca bayrak açıkken — bkz. EnvConfig.enableFirebase)
  if (EnvConfig.enableFirebase) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // App Check (backend kaynaklarını koruma) — Firebase init'ten hemen sonra.
      await AppCheckService.instance.activate();
    } catch (e, s) {
      AppLogger.error(
        'Firebase başlatılamadı. firebase_options.dart ve platform '
        'config dosyalarını kontrol edin.',
        tag: 'Firebase',
        error: e,
        stackTrace: s,
      );
    }
  }

  // Servisler
  await StorageService.instance.init();
  await ConnectivityService.instance.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      initialRoute: NavigationConstants.splash,
      title: 'PhiCore',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      // Analytics: ekran geçişlerini otomatik izler (kapalıyken boş liste).
      navigatorObservers: AnalyticsService.instance.navigatorObservers,

      // Localization
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      builder: (context, child) => AppConnectivityBanner(
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
