import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:phicore/core/utils/app_logger.dart';

/// İnternet bağlantısı durumunu yöneten servis.
///
/// Kullanım:
/// ```dart
/// final connectivity = ConnectivityService.instance;
/// connectivity.onStatusChange.listen((isOnline) {
///   // ...
/// });
///
/// if (connectivity.isOnline) { ... }
/// ```
class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._init();
  static ConnectivityService get instance => _instance;

  final Connectivity _connectivity = Connectivity();

  final _statusController = StreamController<bool>.broadcast();
  Stream<bool> get onStatusChange => _statusController.stream;

  bool _isOnline = true;
  bool get isOnline => _isOnline;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityService._init();

  /// Uygulamanın başlangıcında çağrılmalı.
  Future<void> init() async {
    // İlk durumu sessizce oku — stream'e event gönderme
    final results = await _connectivity.checkConnectivity();
    _isOnline = results.any((r) => r != ConnectivityResult.none);
    AppLogger.info(
      'Başlangıç: ${_isOnline ? "Çevrimiçi" : "Çevrimdışı"}',
      tag: 'ConnectivityService',
    );

    // Değişimleri dinlemeye başla
    _subscription = _connectivity.onConnectivityChanged.listen(
      _updateStatus,
      onError: (error) {
        AppLogger.error('Connectivity error: $error', tag: 'ConnectivityService');
      },
    );
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final wasOnline = _isOnline;
    _isOnline = results.any((r) => r != ConnectivityResult.none);

    if (wasOnline != _isOnline) {
      AppLogger.info(
        _isOnline ? 'Çevrimiçi' : 'Çevrimdışı',
        tag: 'ConnectivityService',
      );
      _statusController.add(_isOnline);
    }
  }

  void dispose() {
    _subscription?.cancel();
    _statusController.close();
  }
}
