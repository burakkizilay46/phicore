import 'package:flutter_test/flutter_test.dart';
import 'package:phicore/core/extensions/string_extensions.dart';

void main() {
  group('StringExtensions.isEmail', () {
    test('geçerli email true döner', () {
      expect('test@example.com'.isEmail, isTrue);
      expect('user.name@domain.co'.isEmail, isTrue);
    });

    test('geçersiz email false döner', () {
      expect('notanemail'.isEmail, isFalse);
      expect('test@'.isEmail, isFalse);
      expect(''.isEmail, isFalse);
    });
  });

  group('StringExtensions.capitalize', () {
    test('ilk harfi büyütür', () {
      expect('hello'.capitalize, 'Hello');
      expect('flutter'.capitalize, 'Flutter');
    });

    test('boş string boş kalır', () {
      expect(''.capitalize, '');
    });

    test('tek karakter büyütülür', () {
      expect('a'.capitalize, 'A');
    });
  });

  group('StringExtensions.truncate', () {
    test('maxLength altındaysa aynı kalır', () {
      expect('short'.truncate(10), 'short');
    });

    test('maxLength üstündeyse kesilir ve ... eklenir', () {
      expect('this is a long text'.truncate(10), 'this is a ...');
    });
  });

  group('StringExtensions.nullIfEmpty', () {
    test('boş string null döner', () {
      expect(''.nullIfEmpty, isNull);
    });

    test('dolu string kendisini döner', () {
      expect('test'.nullIfEmpty, 'test');
    });
  });

  group('NullableStringExtensions', () {
    test('null string isNullOrEmpty true döner', () {
      const String? nullStr = null;
      expect(nullStr.isNullOrEmpty, isTrue);
      expect(''.isNullOrEmpty, isTrue);
    });

    test('dolu string isNullOrEmpty false döner', () {
      expect('test'.isNullOrEmpty, isFalse);
    });

    test('null string isNotNullOrEmpty false döner', () {
      const String? nullStr = null;
      expect(nullStr.isNotNullOrEmpty, isFalse);
    });

    test('dolu string isNotNullOrEmpty true döner', () {
      expect('test'.isNotNullOrEmpty, isTrue);
    });
  });
}
