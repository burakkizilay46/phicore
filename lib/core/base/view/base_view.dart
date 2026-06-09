import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/base/view_model/base_state.dart';

/// BaseState'e göre otomatik UI render eden yardımcı widget.
/// Her feature view'ında tekrarlı switch/when yazmayı önler.
///
/// Kullanım:
/// ```dart
/// BaseView<UserModel>(
///   provider: userViewModelProvider,
///   onLoaded: (data) => UserContent(data),
///   // onLoading, onError, onInitial opsiyonel
/// )
/// ```
class BaseView<T> extends ConsumerWidget {
  final StateNotifierProvider<dynamic, BaseState<T>> provider;
  final Widget Function(T data) onLoaded;
  final Widget Function()? onLoading;
  final Widget Function(String message)? onError;
  final Widget Function()? onInitial;

  const BaseView({
    super.key,
    required this.provider,
    required this.onLoaded,
    this.onLoading,
    this.onError,
    this.onInitial,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    return state.when(
      initial: () => onInitial?.call() ?? const SizedBox.shrink(),
      loading: () =>
          onLoading?.call() ??
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      loaded: (data) => onLoaded(data),
      error: (message) =>
          onError?.call(message) ??
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ),
    );
  }
}
