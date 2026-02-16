class AppError {
  final String message;
  final Exception? exception;

  void showException() {}

  const AppError(this.message, this.exception);
}
