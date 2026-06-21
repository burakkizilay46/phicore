import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phicore/core/constants/app_constants.dart';
import 'package:phicore/core/services/analytics/analytics_service.dart';
import 'package:phicore/core/network/response_handler.dart';
import 'package:phicore/core/services/auth/firebase_auth_error.dart';
import 'package:phicore/core/services/auth/i_auth_service.dart';
import 'package:phicore/core/services/storage/storage_service.dart';
import 'package:phicore/core/utils/app_logger.dart';
import 'package:phicore/features/auth/sign_in/data/model/auth_user_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// [IAuthService]'in Firebase Auth implementasyonu.
///
/// Email/şifre, Google ve Apple ile giriş; şifre sıfırlama ve oturum yönetimi.
/// `EnvConfig.enableFirebase` açıkken `authServiceProvider` bu sınıfı seçer.
class FirebaseAuthService implements IAuthService {
  static const String _tag = 'FirebaseAuthService';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageService _storage = StorageService.instance;

  @override
  Future<ResponseHandler<UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _handleCredential(cred, loginMethod: 'password');
    } on FirebaseAuthException catch (e) {
      return ResponseHandler.failure(FirebaseAuthError.message(e));
    } catch (e, s) {
      return _unexpected(e, s);
    }
  }

  @override
  Future<ResponseHandler<UserModel>> register({
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user == null) {
        return const ResponseHandler.failure('Kayıt başarısız oldu');
      }
      await user.updateDisplayName('$name $surname');
      await _persistToken(user);
      await AnalyticsService.instance.logSignUp('password');

      return ResponseHandler.success(
        UserModel(id: user.uid, email: email, name: name, surname: surname),
      );
    } on FirebaseAuthException catch (e) {
      return ResponseHandler.failure(FirebaseAuthError.message(e));
    } catch (e, s) {
      return _unexpected(e, s);
    }
  }

  @override
  Future<ResponseHandler<UserModel>> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return const ResponseHandler.failure('Google ile giriş iptal edildi');
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final cred = await _auth.signInWithCredential(credential);
      return _handleCredential(cred, loginMethod: 'google');
    } on FirebaseAuthException catch (e) {
      return ResponseHandler.failure(FirebaseAuthError.message(e));
    } catch (e, s) {
      return _unexpected(e, s);
    }
  }

  @override
  Future<ResponseHandler<UserModel>> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      final cred = await _auth.signInWithCredential(oauthCredential);
      final user = cred.user;
      if (user == null) {
        return const ResponseHandler.failure('Apple ile giriş başarısız oldu');
      }

      // Apple ad/soyadı yalnızca ilk girişte döner; displayName boşsa doldur.
      if ((user.displayName ?? '').isEmpty &&
          appleCredential.givenName != null) {
        final fullName =
            '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'
                .trim();
        if (fullName.isNotEmpty) await user.updateDisplayName(fullName);
      }
      await _persistToken(user);
      await AnalyticsService.instance.logLogin('apple');
      return ResponseHandler.success(UserModel.fromFirebase(user));
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return const ResponseHandler.failure('Apple ile giriş iptal edildi');
      }
      return ResponseHandler.failure(e.message);
    } on FirebaseAuthException catch (e) {
      return ResponseHandler.failure(FirebaseAuthError.message(e));
    } catch (e, s) {
      return _unexpected(e, s);
    }
  }

  @override
  Future<ResponseHandler<bool>> forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const ResponseHandler.success(true);
    } on FirebaseAuthException catch (e) {
      return ResponseHandler.failure(FirebaseAuthError.message(e));
    } catch (e, s) {
      AppLogger.error('forgotPassword', tag: _tag, error: e, stackTrace: s);
      return const ResponseHandler.failure('Beklenmeyen bir hata oluştu');
    }
  }

  @override
  Future<ResponseHandler<bool>> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      await _storage.removeSecure(AppConstants.tokenKey);
      await _storage.removeSecure(AppConstants.refreshTokenKey);
      return const ResponseHandler.success(true);
    } catch (e, s) {
      AppLogger.error('signOut', tag: _tag, error: e, stackTrace: s);
      return const ResponseHandler.failure('Çıkış yapılamadı');
    }
  }

  @override
  Future<bool> isAuthenticated() async => _auth.currentUser != null;

  // ── Yardımcılar ──

  Future<ResponseHandler<UserModel>> _handleCredential(
    UserCredential cred, {
    required String loginMethod,
  }) async {
    final user = cred.user;
    if (user == null) {
      return const ResponseHandler.failure('Giriş başarısız oldu');
    }
    await _persistToken(user);
    await AnalyticsService.instance.logLogin(loginMethod);
    return ResponseHandler.success(UserModel.fromFirebase(user));
  }

  /// Firebase ID token'ını mevcut akışla uyum için güvenli depoya yazar
  /// (AuthInterceptor ve splash kontrolü değişmeden çalışsın diye).
  Future<void> _persistToken(User user) async {
    final token = await user.getIdToken();
    if (token != null && token.isNotEmpty) {
      await _storage.setSecure(AppConstants.tokenKey, token);
    }
  }

  ResponseHandler<UserModel> _unexpected(Object e, StackTrace s) {
    AppLogger.error('Beklenmeyen auth hatası', tag: _tag, error: e, stackTrace: s);
    return const ResponseHandler.failure('Beklenmeyen bir hata oluştu');
  }
}
