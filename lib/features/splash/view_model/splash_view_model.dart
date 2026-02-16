import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/service/navigation_service.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, bool>((
  ref,
) {
  return SplashViewModel();
});

class SplashViewModel extends StateNotifier<bool> {
  SplashViewModel() : super(false) {
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(Duration(seconds: 2));
    await NavigationService.instance.navigateToPageClear(
      path: NavigationConstants.sign_in,
    );
  }
}
