import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/base/view_model/base_state.dart';
import 'package:phicore/core/network/response_handler.dart';
import 'package:phicore/core/utils/app_logger.dart';

/// Tüm ViewModel'lerin extend edeceği base sınıf.
/// Loading/error/data state geçişlerini ve ResponseHandler entegrasyonunu sağlar.
///
/// Kullanım:
/// ```dart
/// class MyViewModel extends BaseViewModel<MyData> {
///   MyViewModel() : super() { load(); }
///
///   Future<void> load() => execute(() => myService.fetchData());
/// }
/// ```
class BaseViewModel<T> extends StateNotifier<BaseState<T>> {
  BaseViewModel() : super(const BaseState.initial());

  /// Mevcut data'ya erişim (loaded state'teyse).
  T? get data => state.maybeWhen(loaded: (d) => d, orElse: () => null);

  bool get isLoading => state.maybeWhen(loading: () => true, orElse: () => false);

  /// API çağrısını execute eder ve state'i otomatik yönetir.
  Future<void> execute(
    Future<ResponseHandler<T>> Function() call, {
    bool showLoading = true,
  }) async {
    if (showLoading) state = const BaseState.loading();

    final result = await call();

    result.when(
      success: (data) => state = BaseState.loaded(data),
      failure: (message) {
        AppLogger.error(message, tag: runtimeType.toString());
        state = BaseState.error(message);
      },
    );
  }

  /// Data'yı doğrudan set eder (cache, local vb. için).
  void setData(T data) => state = BaseState.loaded(data);

  /// Error state'e geçirir.
  void setError(String message) => state = BaseState.error(message);

  /// Initial state'e döndürür.
  void reset() => state = const BaseState.initial();
}
