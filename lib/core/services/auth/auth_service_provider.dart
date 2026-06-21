import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/constants/env_config.dart';
import 'package:phicore/core/services/auth/auth_service.dart';
import 'package:phicore/core/services/auth/firebase_auth_service.dart';
import 'package:phicore/core/services/auth/i_auth_service.dart';

/// Aktif kimlik doğrulama servisini sağlar.
///
/// `EnvConfig.enableFirebase` açıksa [FirebaseAuthService], değilse mock
/// [AuthService] döner. ViewModel'ler bu provider üzerinden beslenir; böylece
/// Firebase kurulumu olmadan da template çalışır.
final authServiceProvider = Provider<IAuthService>((ref) {
  return EnvConfig.enableFirebase ? FirebaseAuthService() : AuthService();
});
