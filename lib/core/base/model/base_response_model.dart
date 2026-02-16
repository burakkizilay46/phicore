class BaseResponseModel<T> {
  final T data;
  final String message;

  const BaseResponseModel({required this.data, required this.message});
}
