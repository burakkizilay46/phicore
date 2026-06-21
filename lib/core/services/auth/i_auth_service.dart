import 'package:phicore/core/network/response_handler.dart';
import 'package:phicore/features/auth/sign_in/data/model/auth_user_model.dart';

abstract class IAuthService {
  Future<ResponseHandler<UserModel>> signIn({
    required String email,
    required String password,
  });

  Future<ResponseHandler<UserModel>> register({
    required String name,
    required String surname,
    required String email,
    required String password,
  });

  Future<ResponseHandler<UserModel>> signInWithGoogle();

  Future<ResponseHandler<UserModel>> signInWithApple();

  Future<ResponseHandler<bool>> forgotPassword({required String email});

  Future<ResponseHandler<bool>> signOut();

  Future<bool> isAuthenticated();
}
