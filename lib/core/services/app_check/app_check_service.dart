import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:phicore/core/config/firebase_config.dart';
import 'package:phicore/core/constants/env_config.dart';
import 'package:phicore/core/utils/app_logger.dart';

/// Firebase App Check sarmalayıcısı (singleton).
///
/// App Check, backend kaynaklarınıza (Auth, Firestore, Functions vb.) yalnızca
/// gerçek uygulamanızdan erişilmesini sağlar.
///
/// `EnvConfig.enableFirebase` veya `FirebaseConfig.enableAppCheck` kapalıyken
/// [activate] **no-op**'tur.
///
/// Bu template Android + iOS hedefler:
/// - Debug (dev): `AndroidProvider.debug` / `AppleProvider.debug` — konsola
///   debug token yazılır; bunu Firebase Console → App Check → "Manage debug
///   tokens" altına ekleyin.
/// - Üretim: `AndroidProvider.playIntegrity` / `AppleProvider.deviceCheck`.
class AppCheckService {
  static const String _tag = 'AppCheck';

  static final AppCheckService _instance = AppCheckService._init();
  static AppCheckService get instance => _instance;

  AppCheckService._init();

  bool get _enabled =>
      EnvConfig.enableFirebase && FirebaseConfig.enableAppCheck;

  /// App Check sağlayıcılarını etkinleştirir. `main.dart`'ta
  /// `Firebase.initializeApp` sonrası çağrılmalıdır.
  Future<void> activate() async {
    if (!_enabled) return;
    final useDebug = FirebaseConfig.useAppCheckDebugProvider;
    try {
      await FirebaseAppCheck.instance.activate(
        providerAndroid: useDebug
            ? AndroidDebugProvider()
            : AndroidPlayIntegrityProvider(),
        providerApple:
            useDebug ? AppleDebugProvider() : AppleDeviceCheckProvider(),
      );
    } catch (e, s) {
      AppLogger.error('App Check etkinleştirilemedi', tag: _tag, error: e, stackTrace: s);
    }
  }
}
