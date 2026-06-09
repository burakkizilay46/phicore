import 'package:dio/dio.dart';
import 'package:phicore/core/network/app_error.dart';
import 'package:phicore/core/network/response_handler.dart';

/// Network çağrılarını try-catch ile sarmalayıp ResponseHandler döndürür.
/// Her service'te tekrar eden boilerplate'i ortadan kaldırır.
///
/// Kullanım:
/// ```dart
/// final result = await NetworkExecutor.execute<UserModel>(
///   () => _dio.get('/user/me'),
///   parser: (data) => UserModel.fromJson(data),
/// );
/// ```
class NetworkExecutor {
  NetworkExecutor._();

  /// API çağrısını execute eder, sonucu parse edip ResponseHandler döner.
  static Future<ResponseHandler<T>> execute<T>(
    Future<Response<dynamic>> Function() call, {
    required T Function(dynamic data) parser,
  }) async {
    try {
      final response = await call();
      final parsed = parser(response.data);
      return ResponseHandler.success(parsed);
    } on DioException catch (e) {
      return ResponseHandler.failure(AppError.fromDio(e).message);
    } catch (e) {
      return ResponseHandler.failure(AppError.fromException(e).message);
    }
  }

  /// Parse gerektirmeyen çağrılar için (delete, logout vb.)
  static Future<ResponseHandler<bool>> executeVoid(
    Future<Response<dynamic>> Function() call,
  ) async {
    try {
      await call();
      return const ResponseHandler.success(true);
    } on DioException catch (e) {
      return ResponseHandler.failure(AppError.fromDio(e).message);
    } catch (e) {
      return ResponseHandler.failure(AppError.fromException(e).message);
    }
  }
}
