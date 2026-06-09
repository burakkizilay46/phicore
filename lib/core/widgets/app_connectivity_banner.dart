import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phicore/core/constants/app_constants.dart';
import 'package:phicore/core/services/connectivity/connectivity_service.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_radius.dart';

/// Bağlantı durumu değiştiğinde floating glass toast gösteren overlay widget.
/// Uygulama açılışında gösterilmez — sadece bağlantı koptuğunda ve
/// koptuktan sonra geri geldiğinde tetiklenir.
///
/// Kullanım (MaterialApp.builder):
/// ```dart
/// MaterialApp(
///   builder: (context, child) => AppConnectivityBanner(child: child!),
/// )
/// ```
class AppConnectivityBanner extends StatefulWidget {
  final Widget child;

  const AppConnectivityBanner({super.key, required this.child});

  @override
  State<AppConnectivityBanner> createState() => _AppConnectivityBannerState();
}

class _AppConnectivityBannerState extends State<AppConnectivityBanner>
    with SingleTickerProviderStateMixin {
  late final StreamSubscription<bool> _subscription;
  late final AnimationController _pulseController;
  bool _hasDisconnectedOnce = false;
  bool _isOffline = false;
  bool _showToast = false;
  Timer? _hideTimer;
  bool _ready = false;

  @override
  void initState() {
    super.initState();

    // Offline durum noktası pulse animasyonu
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Başlangıçta kısa bir süre bekle — connectivity_plus'ın
    // rapid-fire initial event'lerini yoksay
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      _ready = true;
    });

    _subscription =
        ConnectivityService.instance.onStatusChange.listen((isOnline) {
      if (!mounted || !_ready) return;

      // Önceki auto-hide timer'ı iptal et
      _hideTimer?.cancel();

      if (!isOnline) {
        _hasDisconnectedOnce = true;
        _pulseController.repeat(reverse: true);
        setState(() {
          _isOffline = true;
          _showToast = true;
        });
      } else if (_hasDisconnectedOnce) {
        _pulseController.stop();
        _pulseController.value = 1.0;
        setState(() {
          _isOffline = false;
          _showToast = true;
        });
        _hideTimer = Timer(const Duration(seconds: 3), () {
          if (mounted) setState(() => _showToast = false);
        });
      }
    });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _pulseController.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        // Toast — ortada, compact
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: Center(
              child: AnimatedOpacity(
                opacity: _showToast ? 1.0 : 0.0,
                duration: AppConstants.animNormal,
                curve: Curves.easeOut,
                child: AnimatedSlide(
                  offset: Offset(0, _showToast ? 0 : -1.0),
                  duration: AppConstants.animNormal,
                  curve: Curves.easeOutCubic,
                  child: _buildToast(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToast() {
    final isOffline = _isOffline;
    final statusColor = isOffline ? AppColors.error : AppColors.success;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.surfaceLight.withValues(alpha: 0.85),
                AppColors.surface.withValues(alpha: 0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(
              color: statusColor.withValues(alpha: 0.25),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: statusColor.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Durum noktası — offline'da pulse animasyonu
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  final opacity =
                      isOffline ? 0.5 + (_pulseController.value * 0.5) : 1.0;
                  return Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: opacity),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: statusColor.withValues(alpha: 0.4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              // İkon
              Icon(
                isOffline ? Icons.wifi_off_rounded : Icons.wifi_rounded,
                size: 16,
                color: statusColor,
              ),
              const SizedBox(width: 8),
              // Mesaj
              Text(
                isOffline ? 'Bağlantı kesildi' : 'Tekrar bağlandı',
                style: TextStyle(
                  color: AppColors.grey90,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
