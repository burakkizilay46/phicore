import 'package:phicore/core/constants/app_constants.dart';
import 'package:phicore/core/network/response_handler.dart';
import 'package:phicore/core/services/auth/i_auth_service.dart';
import 'package:phicore/core/services/storage/storage_service.dart';
import 'package:phicore/features/auth/sign_in/data/model/auth_user_model.dart';

class AuthService extends IAuthService {
  final StorageService _storage = StorageService.instance;

  @override
  Future<ResponseHandler<UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    // TODO: Gerçek API çağrısı ile değiştirilecek
    await Future.delayed(const Duration(seconds: 1));

    if (password.length < AppConstants.passwordMinLength) {
      return const ResponseHandler.failure('Geçersiz şifre');
    }

    final mockUser = UserModel(
      id: 'usr_001',
      email: email,
      name: 'Burak',
      surname: 'Kızılay',
    );

    // Token kaydet
    await _storage.setSecure(AppConstants.tokenKey, 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}');
    await _storage.setSecure(AppConstants.refreshTokenKey, 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}');

    return ResponseHandler.success(mockUser);
  }

  @override
  Future<ResponseHandler<UserModel>> register({
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    // TODO: Gerçek API çağrısı ile değiştirilecek
    await Future.delayed(const Duration(seconds: 1));

    final mockUser = UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      name: name,
      surname: surname,
    );

    // Token kaydet
    await _storage.setSecure(AppConstants.tokenKey, 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}');
    await _storage.setSecure(AppConstants.refreshTokenKey, 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}');

    return ResponseHandler.success(mockUser);
  }

  @override
  Future<ResponseHandler<bool>> forgotPassword({required String email}) async {
    // TODO: Gerçek API çağrısı ile değiştirilecek
    await Future.delayed(const Duration(seconds: 1));
    return const ResponseHandler.success(true);
  }

  @override
  Future<ResponseHandler<bool>> signOut() async {
    await _storage.removeSecure(AppConstants.tokenKey);
    await _storage.removeSecure(AppConstants.refreshTokenKey);
    return const ResponseHandler.success(true);
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await _storage.getSecure(AppConstants.tokenKey);
    return token != null && token.isNotEmpty;
  }
}
