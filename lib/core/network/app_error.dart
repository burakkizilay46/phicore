import 'dart:io';
import 'package:dio/dio.dart';

/// Uygulama genelinde kullanılan hata modeli.
/// Dio hatalarını anlamlı mesajlara çevirir.
class AppError {
  final String message;
  final int? statusCode;
  final dynamic exception;

  const AppError({
    required this.message,
    this.statusCode,
    this.exception,
  });

  /// DioException'dan AppError oluşturur.
  factory AppError.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError(
          message: 'Bağlantı zaman aşımına uğradı',
          statusCode: e.response?.statusCode,
          exception: e,
        );
      case DioExceptionType.connectionError:
        return const AppError(
          message: 'İnternet bağlantısı bulunamadı',
        );
      case DioExceptionType.badResponse:
        return AppError(
          message: _parseStatusCode(e.response?.statusCode),
          statusCode: e.response?.statusCode,
          exception: e,
        );
      case DioExceptionType.cancel:
        return AppError(
          message: 'İstek iptal edildi',
          exception: e,
        );
      default:
        return AppError(
          message: 'Beklenmeyen bir hata oluştu',
          exception: e,
        );
    }
  }

  /// Genel Exception'dan AppError oluşturur.
  factory AppError.fromException(dynamic e) {
    if (e is DioException) return AppError.fromDio(e);
    if (e is SocketException) {
      return const AppError(message: 'İnternet bağlantısı bulunamadı');
    }
    return AppError(
      message: e.toString(),
      exception: e,
    );
  }

  static String _parseStatusCode(int? code) {
    switch (code) {
      case 400:
        return 'Geçersiz istek';
      case 401:
        return 'Oturum süresi doldu';
      case 403:
        return 'Erişim reddedildi';
      case 404:
        return 'Kaynak bulunamadı';
      case 409:
        return 'Çakışma hatası';
      case 422:
        return 'Doğrulama hatası';
      case 429:
        return 'Çok fazla istek gönderildi';
      case 500:
        return 'Sunucu hatası';
      case 502:
      case 503:
        return 'Sunucu geçici olarak kullanılamıyor';
      default:
        return 'Bir hata oluştu ($code)';
    }
  }

  @override
  String toString() => 'AppError($statusCode): $message';
}
