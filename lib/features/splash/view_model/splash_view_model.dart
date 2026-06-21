import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/service/navigation_service.dart';
import 'package:phicore/core/services/auth/auth_service_provider.dart';
import 'package:phicore/core/services/auth/i_auth_service.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, bool>((
  ref,
) {
  return SplashViewModel(ref.read(authServiceProvider));
});

class SplashViewModel extends StateNotifier<bool> {
  SplashViewModel(this._authService) : super(false) {
    _init();
  }

  final IAuthService _authService;

  Future<void> _init() async {
    // Splash animasyonu için minimum bekleme
    await Future.delayed(const Duration(seconds: 2));

    // Auth kontrolü
    final isAuthenticated = await _authService.isAuthenticated();

    final targetRoute = isAuthenticated
        ? NavigationConstants.home
        : NavigationConstants.signIn;

    await NavigationService.instance.navigateToPageClear(path: targetRoute);
  }
}
