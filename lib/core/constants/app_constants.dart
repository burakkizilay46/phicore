/// Uygulama genelinde kullanılan sabit değerler.
class AppConstants {
  AppConstants._();

  // ── App ──
  static const String appName = 'PhiCore';
  static const String appVersion = '1.0.0';

  // ── Storage Keys ──
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String onboardingKey = 'onboarding_completed';

  // ── API ──
  static const String contentType = 'application/json';
  static const String accept = 'application/json';

  // ── Pagination ──
  static const int defaultPageSize = 20;

  // ── Animation ──
  static const Duration animFast = Duration(milliseconds: 150);
  static const Duration animNormal = Duration(milliseconds: 300);
  static const Duration animSlow = Duration(milliseconds: 500);

  // ── Validation ──
  static const int passwordMinLength = 6;
  static const int nameMinLength = 2;
  static const int nameMaxLength = 50;
}
