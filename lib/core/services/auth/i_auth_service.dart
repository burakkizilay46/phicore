import 'package:phicore/core/network/response_handler.dart';
import 'package:phicore/features/auth/sign_in/data/model/auth_user_model.dart';

abstract class IAuthService {
  Future<ResponseHandler<UserModel>> signIn({
    required String email,
    required String password,
  });
  Future<ResponseHandler<bool>> signOut();
}
