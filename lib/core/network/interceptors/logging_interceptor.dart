import 'package:dio/dio.dart';
import 'package:phicore/core/utils/app_logger.dart';

/// Request/response log'ları için interceptor.
/// Sadece dev/staging ortamında aktif olur.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.info(
      '→ ${options.method} ${options.uri}',
      tag: 'HTTP',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.info(
      '← ${response.statusCode} ${response.requestOptions.uri}',
      tag: 'HTTP',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error(
      '✕ ${err.response?.statusCode ?? 'NO_STATUS'} ${err.requestOptions.uri}',
      tag: 'HTTP',
      error: err,
    );
    handler.next(err);
  }
}
