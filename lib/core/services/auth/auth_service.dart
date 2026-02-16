import 'package:phicore/core/base/model/base_response_model.dart';
import 'package:phicore/core/network/response_handler.dart';
import 'package:phicore/core/services/auth/IAuthService.dart';
import 'package:phicore/features/auth/sign_in/data/model/auth_user_model.dart';

class AuthService extends IAuthService {
  @override
  Future<ResponseHandler<UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // for API Request Senerio
    final mockuser = UserModel(
      id: 'as12dsq',
      email: email,
      name: 'burak',
      surname: 'kizilay',
    );

    if (password == '123456') {
      final response = BaseResponseModel(
        data: mockuser,
        message: 'Giriş Başarılı',
      );
      return ResponseHandler.success(response.data);
    } else {
      return ResponseHandler.failure('Giriş Başarısız');
    }
  }

  @override
  Future<ResponseHandler<bool>> signOut() async {
    return const ResponseHandler.success(true);
  }
}
