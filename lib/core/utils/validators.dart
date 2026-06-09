import 'package:phicore/core/constants/app_constants.dart';

/// Form validasyon kuralları.
/// TextFormField'ın `validator` parametresi ile kullanılır.
///
/// Kullanım:
/// ```dart
/// AppTextField(
///   label: 'Email',
///   validator: Validators.email,
/// )
/// ```
class Validators {
  Validators._();

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bu alan zorunludur';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email adresi giriniz';
    }
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Geçerli bir email adresi giriniz';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre giriniz';
    }
    if (value.length < AppConstants.passwordMinLength) {
      return 'Şifre en az ${AppConstants.passwordMinLength} karakter olmalıdır';
    }
    return null;
  }

  static String? Function(String?) confirmPassword(String password) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Şifreyi tekrar giriniz';
      }
      if (value != password) {
        return 'Şifreler eşleşmiyor';
      }
      return null;
    };
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'İsim giriniz';
    }
    if (value.trim().length < AppConstants.nameMinLength) {
      return 'En az ${AppConstants.nameMinLength} karakter olmalıdır';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Telefon numarası giriniz';
    }
    final regex = RegExp(r'^\+?[0-9]{10,15}$');
    if (!regex.hasMatch(value.replaceAll(' ', ''))) {
      return 'Geçerli bir telefon numarası giriniz';
    }
    return null;
  }

  /// Min uzunluk kuralı. Parametrik kullanım için.
  static String? Function(String?) minLength(int min) {
    return (String? value) {
      if (value == null || value.length < min) {
        return 'En az $min karakter olmalıdır';
      }
      return null;
    };
  }

  /// Birden fazla validator'ü zincirler.
  /// İlk hata veren kuralın mesajını döner.
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}
