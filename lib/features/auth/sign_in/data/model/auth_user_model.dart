import 'package:phicore/core/base/model/base_user_model.dart';

class UserModel extends BaseUserModel {
  final String name;
  final String surname;

  const UserModel({
    required String id,
    required String email,
    required this.name,
    required this.surname,
  }) : super(id, email);
}
