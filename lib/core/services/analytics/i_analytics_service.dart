import 'package:flutter/widgets.dart' show NavigatorObserver;

/// Analytics servis arayüzü.
abstract class IAnalyticsService {
  /// Özel bir event loglar.
  Future<void> logEvent(String name, {Map<String, Object>? parameters});

  /// Giriş event'i (`login`).
  Future<void> logLogin(String method);

  /// Kayıt event'i (`sign_up`).
  Future<void> logSignUp(String method);

  /// Aktif kullanıcı kimliğini ayarlar (çıkışta `null` geçin).
  Future<void> setUserId(String? id);

  /// Kullanıcı özelliği ayarlar.
  Future<void> setUserProperty({required String name, required String? value});

  /// `MaterialApp.navigatorObservers`'a eklenecek observer listesi.
  /// Analytics kapalıyken boş liste döner.
  List<NavigatorObserver> get navigatorObservers;
}
