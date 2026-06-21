import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart' show NavigatorObserver;
import 'package:phicore/core/config/firebase_config.dart';
import 'package:phicore/core/constants/env_config.dart';
import 'package:phicore/core/services/analytics/i_analytics_service.dart';

/// Firebase Analytics sarmalayıcısı (singleton).
///
/// `EnvConfig.enableFirebase` veya `FirebaseConfig.enableAnalytics` kapalıyken
/// tüm metotlar **no-op**'tur; böylece Firebase başlatılmamışken bile uygulama
/// güvenle çalışır. `ConnectivityService`/`StorageService` ile ayni singleton
/// desenini izler.
class AnalyticsService implements IAnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._init();
  static AnalyticsService get instance => _instance;

  AnalyticsService._init();

  /// Analytics gerçekten aktif mi?
  bool get _enabled =>
      EnvConfig.enableFirebase && FirebaseConfig.enableAnalytics;

  FirebaseAnalytics get _analytics => FirebaseAnalytics.instance;

  @override
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    if (!_enabled) return;
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> logLogin(String method) async {
    if (!_enabled) return;
    await _analytics.logLogin(loginMethod: method);
  }

  @override
  Future<void> logSignUp(String method) async {
    if (!_enabled) return;
    await _analytics.logSignUp(signUpMethod: method);
  }

  @override
  Future<void> setUserId(String? id) async {
    if (!_enabled) return;
    await _analytics.setUserId(id: id);
  }

  @override
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    if (!_enabled) return;
    await _analytics.setUserProperty(name: name, value: value);
  }

  @override
  List<NavigatorObserver> get navigatorObservers => _enabled
      ? [FirebaseAnalyticsObserver(analytics: _analytics)]
      : const [];
}
