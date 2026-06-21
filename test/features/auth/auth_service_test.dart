import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phicore/core/services/auth/auth_service.dart';

void main() {
  // Mock AuthService, token'ları FlutterSecureStorage'a yazar; testte platform
  // kanalı yerine bellek-içi mock kullanılır.
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthService authService;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    authService = AuthService();
  });

  group('AuthService.signIn', () {
    test('geçerli şifre ile başarılı döner', () async {
      final result = await authService.signIn(
        email: 'test@example.com',
        password: '123456',
      );

      result.when(
        success: (user) {
          expect(user.email, 'test@example.com');
          expect(user.name, isNotEmpty);
        },
        failure: (message) => fail('Başarılı olmalıydı: $message'),
      );
    });

    test('kısa şifre ile hata döner', () async {
      final result = await authService.signIn(
        email: 'test@example.com',
        password: '123',
      );

      result.when(
        success: (_) => fail('Hata bekleniyor'),
        failure: (message) => expect(message, isNotEmpty),
      );
    });
  });

  group('AuthService.register', () {
    test('başarılı kayıt', () async {
      final result = await authService.register(
        name: 'Burak',
        surname: 'Kızılay',
        email: 'test@example.com',
        password: '123456',
      );

      result.when(
        success: (user) {
          expect(user.email, 'test@example.com');
          expect(user.name, 'Burak');
          expect(user.surname, 'Kızılay');
        },
        failure: (message) => fail('Başarılı olmalıydı: $message'),
      );
    });
  });

  group('AuthService.signInWithGoogle', () {
    test('mock kullanıcı ile başarılı döner', () async {
      final result = await authService.signInWithGoogle();

      result.when(
        success: (user) {
          expect(user.email, isNotEmpty);
          expect(user.name, isNotEmpty);
        },
        failure: (message) => fail('Başarılı olmalıydı: $message'),
      );
    });
  });

  group('AuthService.signInWithApple', () {
    test('mock kullanıcı ile başarılı döner', () async {
      final result = await authService.signInWithApple();

      result.when(
        success: (user) {
          expect(user.email, isNotEmpty);
          expect(user.name, isNotEmpty);
        },
        failure: (message) => fail('Başarılı olmalıydı: $message'),
      );
    });
  });

  group('AuthService.forgotPassword', () {
    test('başarılı şifre sıfırlama talebi', () async {
      final result = await authService.forgotPassword(
        email: 'test@example.com',
      );

      result.when(
        success: (success) => expect(success, isTrue),
        failure: (message) => fail('Başarılı olmalıydı: $message'),
      );
    });
  });

  group('AuthService.signOut', () {
    test('başarılı çıkış', () async {
      final result = await authService.signOut();

      result.when(
        success: (success) => expect(success, isTrue),
        failure: (message) => fail('Başarılı olmalıydı: $message'),
      );
    });
  });
}
