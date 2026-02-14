import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_handler.freezed.dart';

@freezed
class ResponseHandler<T> with _$ResponseHandler<T> {
  const ResponseHandler._();

  const factory ResponseHandler.success(T data) = _Success<T>;
  const factory ResponseHandler.failure(String message) = _Failure<T>;
}
