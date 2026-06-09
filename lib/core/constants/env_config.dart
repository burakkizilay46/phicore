/// Ortam yapılandırması.
/// Uygulama başlatılırken `EnvConfig.init(Environment.dev)` ile set edilir.
enum Environment { dev, staging, prod }

class EnvConfig {
  EnvConfig._();

  static late Environment _env;
  static Environment get environment => _env;

  static bool get isDev => _env == Environment.dev;
  static bool get isStaging => _env == Environment.staging;
  static bool get isProd => _env == Environment.prod;

  static void init(Environment env) => _env = env;

  static String get baseUrl {
    switch (_env) {
      case Environment.dev:
        return 'https://dev-api.phicore.com';
      case Environment.staging:
        return 'https://staging-api.phicore.com';
      case Environment.prod:
        return 'https://api.phicore.com';
    }
  }

  static Duration get connectTimeout {
    switch (_env) {
      case Environment.dev:
        return const Duration(seconds: 30);
      case Environment.staging:
      case Environment.prod:
        return const Duration(seconds: 15);
    }
  }

  static Duration get receiveTimeout {
    switch (_env) {
      case Environment.dev:
        return const Duration(seconds: 30);
      case Environment.staging:
      case Environment.prod:
        return const Duration(seconds: 15);
    }
  }

  static bool get enableLogging => !isProd;
}
