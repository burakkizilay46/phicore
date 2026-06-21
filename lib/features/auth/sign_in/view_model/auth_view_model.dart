import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/base/view_model/base_state.dart';
import 'package:phicore/core/base/view_model/base_view_model.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/service/navigation_service.dart';
import 'package:phicore/core/services/auth/auth_service_provider.dart';
import 'package:phicore/core/services/auth/i_auth_service.dart';
import 'package:phicore/features/auth/sign_in/data/model/auth_user_model.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, BaseState<UserModel>>((ref) {
  return AuthViewModel(ref.read(authServiceProvider));
});

class AuthViewModel extends BaseViewModel<UserModel> {
  AuthViewModel(this._authService);

  final IAuthService _authService;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await execute(() => _authService.signIn(email: email, password: password));
    _navigateOnSuccess();
  }

  Future<void> signInWithGoogle() async {
    await execute(() => _authService.signInWithGoogle());
    _navigateOnSuccess();
  }

  Future<void> signInWithApple() async {
    await execute(() => _authService.signInWithApple());
    _navigateOnSuccess();
  }

  /// Başarılı giriş → ana sayfaya yönlendir.
  void _navigateOnSuccess() {
    state.maybeWhen(
      loaded: (_) {
        NavigationService.instance.navigateToPageClear(
          path: NavigationConstants.home,
        );
      },
      orElse: () {},
    );
  }
}
