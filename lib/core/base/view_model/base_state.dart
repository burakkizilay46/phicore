import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_state.freezed.dart';

/// Her ViewModel'in kullanacağı temel state yapısı.
/// Loading, error, data üçlüsünü yönetir.
///
/// Kullanım:
/// ```dart
/// final state = ref.watch(myViewModelProvider);
/// state.when(
///   initial: () => SizedBox.shrink(),
///   loading: () => AppLoading(),
///   loaded: (data) => MyContent(data),
///   error: (message) => ErrorWidget(message),
/// );
/// ```
@freezed
class BaseState<T> with _$BaseState<T> {
  const factory BaseState.initial() = _Initial<T>;
  const factory BaseState.loading() = _Loading<T>;
  const factory BaseState.loaded(T data) = _Loaded<T>;
  const factory BaseState.error(String message) = _Error<T>;
}
