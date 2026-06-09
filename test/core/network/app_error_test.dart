import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phicore/core/network/app_error.dart';

void main() {
  group('AppError.fromDio', () {
    test('timeout hatası doğru mesaj döner', () {
      final error = DioException(
        type: DioExceptionType.connectionTimeout,
        requestOptions: RequestOptions(path: '/test'),
      );
      final appError = AppError.fromDio(error);
      expect(appError.message, contains('zaman aşımı'));
    });

    test('401 hatası doğru mesaj döner', () {
      final error = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: '/test'),
        ),
        requestOptions: RequestOptions(path: '/test'),
      );
      final appError = AppError.fromDio(error);
      expect(appError.message, contains('Oturum'));
    });

    test('404 hatası doğru mesaj döner', () {
      final error = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(path: '/test'),
        ),
        requestOptions: RequestOptions(path: '/test'),
      );
      final appError = AppError.fromDio(error);
      expect(appError.message, contains('bulunamadı'));
    });

    test('500 hatası doğru mesaj döner', () {
      final error = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 500,
          requestOptions: RequestOptions(path: '/test'),
        ),
        requestOptions: RequestOptions(path: '/test'),
      );
      final appError = AppError.fromDio(error);
      expect(appError.message, contains('Sunucu'));
    });

    test('cancel hatası doğru mesaj döner', () {
      final error = DioException(
        type: DioExceptionType.cancel,
        requestOptions: RequestOptions(path: '/test'),
      );
      final appError = AppError.fromDio(error);
      expect(appError.message, contains('iptal'));
    });
  });

  group('AppError.fromException', () {
    test('genel exception mesajı döner', () {
      final appError = AppError.fromException(Exception('something failed'));
      expect(appError.message, isNotEmpty);
    });
  });
}
