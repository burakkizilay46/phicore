import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/base/view_model/base_state.dart';
import 'package:phicore/core/base/view_model/base_view_model.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/service/navigation_service.dart';
import 'package:phicore/core/services/auth/auth_service_provider.dart';
import 'package:phicore/core/services/auth/i_auth_service.dart';
import 'package:phicore/features/auth/sign_in/data/model/auth_user_model.dart';

final registerViewModelProvider =
    StateNotifierProvider<RegisterViewModel, BaseState<UserModel>>((ref) {
  return RegisterViewModel(ref.read(authServiceProvider));
});

class RegisterViewModel extends BaseViewModel<UserModel> {
  RegisterViewModel(this._authService);

  final IAuthService _authService;

  Future<void> register({
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    await execute(
      () => _authService.register(
        name: name,
        surname: surname,
        email: email,
        password: password,
      ),
    );

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
