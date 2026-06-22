import 'package:flutter/foundation.dart';

/// Onboarding akışının yerel UI state'i.
///
/// Tamamen bellek-içinde tutulur (kalıcı kayıt yok). Network/async olmadığı için
/// `BaseState` (initial/loading/loaded/error) yerine sade bir immutable state
/// kullanılır.
@immutable
class OnboardingState {
  /// Aktif adımın [OnboardingConfig.steps] içindeki index'i.
  final int currentIndex;

  /// Verilen cevaplar: `OnboardingQuestionStep.key` → seçilen `option.value`.
  final Map<String, String> answers;

  const OnboardingState({
    this.currentIndex = 0,
    this.answers = const {},
  });

  OnboardingState copyWith({
    int? currentIndex,
    Map<String, String>? answers,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingState &&
          other.currentIndex == currentIndex &&
          mapEquals(other.answers, answers);

  @override
  int get hashCode => Object.hash(currentIndex, Object.hashAllUnordered(answers.entries));
}
