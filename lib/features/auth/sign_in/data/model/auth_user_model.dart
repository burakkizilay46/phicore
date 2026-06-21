import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:phicore/core/base/model/base_user_model.dart';

class UserModel extends BaseUserModel {
  final String name;
  final String surname;
  final String? photoUrl;

  const UserModel({
    required String id,
    required String email,
    required this.name,
    required this.surname,
    this.photoUrl,
  }) : super(id, email);

  /// Firebase [User] nesnesinden [UserModel] üretir.
  ///
  /// `displayName` tek bir alan olduğu için ad/soyad olarak en iyi çaba ile
  /// bölünür (ilk kelime ad, kalanı soyad). Sosyal sağlayıcılarda
  /// `displayName`/`email` null gelebilir → güvenli varsayılanlar kullanılır.
  factory UserModel.fromFirebase(User user) {
    final parts = (user.displayName ?? '').trim().split(RegExp(r'\s+'));
    final name = parts.isNotEmpty ? parts.first : '';
    final surname = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: name,
      surname: surname,
      photoUrl: user.photoURL,
    );
  }
}
