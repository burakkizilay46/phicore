import 'package:flutter_test/flutter_test.dart';
import 'package:phicore/core/utils/validators.dart';

void main() {
  group('Validators.required', () {
    test('null ise hata mesajı döner', () {
      expect(Validators.required(null), isNotNull);
    });

    test('boş string ise hata mesajı döner', () {
      expect(Validators.required(''), isNotNull);
    });

    test('sadece boşluk ise hata mesajı döner', () {
      expect(Validators.required('   '), isNotNull);
    });

    test('geçerli değer ise null döner', () {
      expect(Validators.required('test'), isNull);
    });
  });

  group('Validators.email', () {
    test('null ise hata mesajı döner', () {
      expect(Validators.email(null), isNotNull);
    });

    test('boş string ise hata mesajı döner', () {
      expect(Validators.email(''), isNotNull);
    });

    test('geçersiz format ise hata mesajı döner', () {
      expect(Validators.email('notanemail'), isNotNull);
      expect(Validators.email('test@'), isNotNull);
      expect(Validators.email('@domain.com'), isNotNull);
      expect(Validators.email('test@domain'), isNotNull);
    });

    test('geçerli email ise null döner', () {
      expect(Validators.email('test@example.com'), isNull);
      expect(Validators.email('user.name@domain.co'), isNull);
      expect(Validators.email('user+tag@example.org'), isNull);
    });
  });

  group('Validators.password', () {
    test('null ise hata mesajı döner', () {
      expect(Validators.password(null), isNotNull);
    });

    test('boş ise hata mesajı döner', () {
      expect(Validators.password(''), isNotNull);
    });

    test('6 karakterden kısa ise hata mesajı döner', () {
      expect(Validators.password('12345'), isNotNull);
    });

    test('6+ karakter ise null döner', () {
      expect(Validators.password('123456'), isNull);
      expect(Validators.password('strongpassword'), isNull);
    });
  });

  group('Validators.confirmPassword', () {
    test('boş ise hata mesajı döner', () {
      final validator = Validators.confirmPassword('password');
      expect(validator(null), isNotNull);
      expect(validator(''), isNotNull);
    });

    test('eşleşmiyorsa hata mesajı döner', () {
      final validator = Validators.confirmPassword('password');
      expect(validator('different'), isNotNull);
    });

    test('eşleşiyorsa null döner', () {
      final validator = Validators.confirmPassword('password');
      expect(validator('password'), isNull);
    });
  });

  group('Validators.name', () {
    test('null ise hata mesajı döner', () {
      expect(Validators.name(null), isNotNull);
    });

    test('1 karakter ise hata mesajı döner', () {
      expect(Validators.name('A'), isNotNull);
    });

    test('2+ karakter ise null döner', () {
      expect(Validators.name('AB'), isNull);
      expect(Validators.name('Burak'), isNull);
    });
  });

  group('Validators.phone', () {
    test('null ise hata mesajı döner', () {
      expect(Validators.phone(null), isNotNull);
    });

    test('geçersiz format ise hata mesajı döner', () {
      expect(Validators.phone('123'), isNotNull);
      expect(Validators.phone('abcdefghij'), isNotNull);
    });

    test('geçerli telefon ise null döner', () {
      expect(Validators.phone('+905551234567'), isNull);
      expect(Validators.phone('5551234567'), isNull);
    });
  });

  group('Validators.minLength', () {
    test('minimum uzunluk altında ise hata döner', () {
      final validator = Validators.minLength(5);
      expect(validator('abc'), isNotNull);
      expect(validator(null), isNotNull);
    });

    test('minimum uzunluk veya üzeri ise null döner', () {
      final validator = Validators.minLength(5);
      expect(validator('abcde'), isNull);
      expect(validator('abcdef'), isNull);
    });
  });

  group('Validators.compose', () {
    test('ilk hata veren kuralın mesajını döner', () {
      final validator = Validators.compose([
        Validators.required,
        Validators.email,
      ]);

      // null → required hatası
      expect(validator(null), contains('zorunlu'));
      // geçersiz email → email hatası
      expect(validator('notanemail'), contains('email'));
      // geçerli → null
      expect(validator('test@example.com'), isNull);
    });
  });
}
