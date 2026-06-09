import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/base/view_model/base_state.dart';
import 'package:phicore/core/base/view_model/base_view_model.dart';
import 'package:phicore/core/services/auth/auth_service.dart';

final forgotPasswordViewModelProvider =
    StateNotifierProvider<ForgotPasswordViewModel, BaseState<bool>>((ref) {
  return ForgotPasswordViewModel();
});

class ForgotPasswordViewModel extends BaseViewModel<bool> {
  final AuthService _authService = AuthService();

  Future<void> sendResetEmail({required String email}) async {
    await execute(() => _authService.forgotPassword(email: email));
  }
}
