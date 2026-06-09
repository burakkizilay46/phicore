import 'dart:async';

/// Tekrarlı çağrıları sınırlandırır (search input vb.)
///
/// Kullanım:
/// ```dart
/// final _debouncer = Debouncer();
/// onChanged: (value) => _debouncer.run(() => search(value)),
/// ```
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 400)});

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  bool get isActive => _timer?.isActive ?? false;
}
