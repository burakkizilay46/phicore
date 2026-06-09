import 'package:flutter_test/flutter_test.dart';
import 'package:phicore/core/utils/debouncer.dart';

void main() {
  group('Debouncer', () {
    test('delay sonunda callback çağrılır', () async {
      final debouncer = Debouncer(delay: const Duration(milliseconds: 100));
      int callCount = 0;

      debouncer.run(() => callCount++);

      expect(callCount, 0);
      await Future.delayed(const Duration(milliseconds: 150));
      expect(callCount, 1);
    });

    test('peş peşe çağrılarda sadece son callback çalışır', () async {
      final debouncer = Debouncer(delay: const Duration(milliseconds: 100));
      int callCount = 0;

      debouncer.run(() => callCount++);
      debouncer.run(() => callCount++);
      debouncer.run(() => callCount++);

      await Future.delayed(const Duration(milliseconds: 150));
      expect(callCount, 1);
    });

    test('cancel çağrılınca callback çalışmaz', () async {
      final debouncer = Debouncer(delay: const Duration(milliseconds: 100));
      int callCount = 0;

      debouncer.run(() => callCount++);
      debouncer.cancel();

      await Future.delayed(const Duration(milliseconds: 150));
      expect(callCount, 0);
    });
  });
}
