import 'package:dio/dio.dart';
import 'package:phicore/core/constants/app_constants.dart';
import 'package:phicore/core/services/storage/storage_service.dart';

/// Token'ı otomatik olarak her request'e ekler.
/// 401 aldığında token refresh dener.
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await StorageService.instance.getSecure(
      AppConstants.tokenKey,
    );

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // TODO: Token refresh logic
      // final refreshed = await _refreshToken();
      // if (refreshed) retry original request
    }

    handler.next(err);
  }
}
