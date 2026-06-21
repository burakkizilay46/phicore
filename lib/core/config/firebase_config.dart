import 'package:phicore/core/constants/env_config.dart';

/// Firebase özellik bayrakları ve kod düzeyi seçimleri.
///
/// Bu, template kullanıcısının düzenleyeceği **tek kod dosyasıdır**. Gerçek
/// anahtarlar (apiKey, appId vb.) burada DEĞİL; `firebase_options.dart`,
/// `android/app/google-services.json` ve `ios/Runner/GoogleService-Info.plist`
/// içinde durur.
///
/// > Not: Bu template yalnızca Android + iOS hedefler. App Check için kod düzeyi
/// > anahtar gerekmez (reCAPTCHA sadece web içindir; mobilde Play Integrity /
/// > DeviceCheck kullanılır).
class FirebaseConfig {
  FirebaseConfig._();

  /// Firebase Analytics açık mı? (Faz 2)
  /// `EnvConfig.enableFirebase` kapalıysa bu değerin etkisi yoktur.
  static const bool enableAnalytics = true;

  /// Firebase App Check açık mı? (Faz 3)
  /// `EnvConfig.enableFirebase` kapalıysa bu değerin etkisi yoktur.
  static const bool enableAppCheck = true;

  /// App Check'te debug sağlayıcı kullanılsın mı?
  ///
  /// `dev` ortamında `true` → emülatör/simülatör konsoluna debug token yazılır;
  /// bu token Firebase Console → App Check → "Manage debug tokens" altına eklenir.
  /// `staging`/`prod`'da `false` → Play Integrity (Android) / DeviceCheck (iOS).
  static bool get useAppCheckDebugProvider => EnvConfig.isDev;
}
