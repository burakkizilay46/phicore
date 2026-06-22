import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/constants/app_constants.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/service/navigation_service.dart';
import 'package:phicore/core/services/storage/storage_service.dart';
import 'package:phicore/features/onboarding/config/onboarding_config.dart';
import 'package:phicore/features/onboarding/data/model/onboarding_step.dart';
import 'package:phicore/features/onboarding/view_model/onboarding_state.dart';

final onboardingViewModelProvider =
    StateNotifierProvider.autoDispose<OnboardingViewModel, OnboardingState>(
  (ref) => OnboardingViewModel(),
);

/// Onboarding akışının view model'i.
///
/// Adımlar [OnboardingConfig.steps]'ten okunur. Cevaplar yalnızca state'te
/// tutulur — tamamlanınca giriş ekranına yönlendirilir.
class OnboardingViewModel extends StateNotifier<OnboardingState> {
  OnboardingViewModel() : super(const OnboardingState());

  List<OnboardingStep> get steps => OnboardingConfig.steps;

  OnboardingStep get currentStep => steps[state.currentIndex];

  bool get isFirstStep => state.currentIndex == 0;

  bool get isLastStep => state.currentIndex == steps.length - 1;

  /// Aktif adımın "Devam" için hazır olup olmadığı.
  /// Soru adımıysa cevap verilmiş (ya da `optional`) olmalı; diğer adımlar serbest.
  bool get canAdvance {
    final step = currentStep;
    if (step is OnboardingQuestionStep && !step.optional) {
      return state.answers.containsKey(step.key);
    }
    return true;
  }

  /// Bir soru adımına cevap kaydeder (yalnızca state'te).
  void selectAnswer(String key, String value) {
    state = state.copyWith(answers: {...state.answers, key: value});
  }

  void next() {
    if (isLastStep) {
      complete();
      return;
    }
    state = state.copyWith(currentIndex: state.currentIndex + 1);
  }

  void back() {
    if (isFirstStep) return;
    state = state.copyWith(currentIndex: state.currentIndex - 1);
  }

  /// Akışı bitirir: görüldü bilgisini kaydeder ve giriş ekranına geçer.
  Future<void> complete() async {
    // TODO: Toplanan cevaplar (state.answers) şu an yalnızca bellekte.
    // Backend/analytics/kullanıcı profiline gönderim buraya eklenecek.
    await StorageService.instance.setBool(AppConstants.onboardingKey, true);
    await NavigationService.instance.navigateToPageClear(
      path: NavigationConstants.signIn,
    );
  }

  void skip() => complete();
}
