import 'package:flutter_test/flutter_test.dart';
import 'package:phicore/core/services/auth/firebase_auth_error.dart';

void main() {
  group('FirebaseAuthError.fromCode', () {
    test('bilinen kodları Türkçe mesaja çevirir', () {
      expect(FirebaseAuthError.fromCode('user-not-found'), 'Kullanıcı bulunamadı');
      expect(FirebaseAuthError.fromCode('wrong-password'),
          'E-posta veya şifre hatalı');
      expect(FirebaseAuthError.fromCode('invalid-credential'),
          'E-posta veya şifre hatalı');
      expect(FirebaseAuthError.fromCode('email-already-in-use'),
          'Bu e-posta adresi zaten kullanımda');
      expect(FirebaseAuthError.fromCode('weak-password'),
          'Şifre çok zayıf (en az 6 karakter)');
      expect(FirebaseAuthError.fromCode('network-request-failed'),
          'İnternet bağlantısı bulunamadı');
    });

    test('bilinmeyen kodda fallback mesajı kullanır', () {
      expect(
        FirebaseAuthError.fromCode('something-weird', fallback: 'Özel mesaj'),
        'Özel mesaj',
      );
    });

    test('bilinmeyen kodda ve fallback yoksa kodu içeren mesaj döner', () {
      final msg = FirebaseAuthError.fromCode('something-weird');
      expect(msg, contains('something-weird'));
    });
  });
}
