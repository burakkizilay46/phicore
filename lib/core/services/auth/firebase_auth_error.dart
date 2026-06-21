import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;

/// `FirebaseAuthException` kodlarını kullanıcıya gösterilecek Türkçe mesajlara
/// çevirir. `app_error.dart` desenini takip eder.
class FirebaseAuthError {
  FirebaseAuthError._();

  /// Bir [FirebaseAuthException]'dan kullanıcı dostu mesaj üretir.
  static String message(FirebaseAuthException e) =>
      fromCode(e.code, fallback: e.message);

  /// Hata kodundan Türkçe mesaj döner. Test edilebilirlik için ayrı tutulur.
  static String fromCode(String code, {String? fallback}) {
    switch (code) {
      case 'invalid-email':
        return 'Geçersiz e-posta adresi';
      case 'user-disabled':
        return 'Bu hesap devre dışı bırakılmış';
      case 'user-not-found':
        return 'Kullanıcı bulunamadı';
      case 'wrong-password':
      case 'invalid-credential':
        return 'E-posta veya şifre hatalı';
      case 'email-already-in-use':
        return 'Bu e-posta adresi zaten kullanımda';
      case 'operation-not-allowed':
        return 'Bu giriş yöntemi etkin değil';
      case 'weak-password':
        return 'Şifre çok zayıf (en az 6 karakter)';
      case 'account-exists-with-different-credential':
        return 'Bu e-posta farklı bir giriş yöntemiyle kayıtlı';
      case 'requires-recent-login':
        return 'Bu işlem için tekrar giriş yapmanız gerekiyor';
      case 'too-many-requests':
        return 'Çok fazla başarısız deneme. Lütfen daha sonra tekrar deneyin';
      case 'network-request-failed':
        return 'İnternet bağlantısı bulunamadı';
      default:
        return fallback ?? 'Kimlik doğrulama hatası ($code)';
    }
  }
}
