import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/constants/app_constants.dart';
import 'package:phicore/core/localization/app_localizations.dart';
import 'package:phicore/core/theme/app_spacing.dart';
import 'package:phicore/core/widgets/app_button.dart';
import 'package:phicore/features/onboarding/data/model/onboarding_step.dart';
import 'package:phicore/features/onboarding/view/widgets/onboarding_dots.dart';
import 'package:phicore/features/onboarding/view/widgets/onboarding_info_step.dart';
import 'package:phicore/features/onboarding/view/widgets/onboarding_permission_step.dart';
import 'package:phicore/features/onboarding/view/widgets/onboarding_question_step.dart';
import 'package:phicore/features/onboarding/view_model/onboarding_state.dart';
import 'package:phicore/features/onboarding/view_model/onboarding_view_model.dart';

/// İlk açılışta gösterilen onboarding akışı.
///
/// Adımlar [OnboardingConfig.steps]'ten okunur; geçişler [PageView] ile
/// kontrollü yapılır (kaydırma kapalı, next/back ile ilerlenir).
class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPrimary(OnboardingViewModel vm) {
    if (vm.currentStep is OnboardingPermissionStep) {
      // TODO: Gerçek bildirim izni isteği (permission_handler / firebase_messaging).
    }
    vm.next();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.read(onboardingViewModelProvider.notifier);
    final state = ref.watch(onboardingViewModelProvider);
    final steps = vm.steps;
    final currentStep = steps[state.currentIndex];

    // currentIndex değişince sayfayı animasyonla geçir.
    ref.listen(
      onboardingViewModelProvider.select((s) => s.currentIndex),
      (_, index) {
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            index,
            duration: AppConstants.animNormal,
            curve: Curves.easeInOut,
          );
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(vm, currentStep),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: steps.length,
                itemBuilder: (context, index) =>
                    _buildStep(steps[index], state, vm),
              ),
            ),
            _buildBottomBar(vm, state, steps.length),
          ],
        ),
      ),
    );
  }

  /// Üst çubuk: "Atla" yalnızca tanıtım slaytlarında görünür.
  Widget _buildTopBar(OnboardingViewModel vm, OnboardingStep currentStep) {
    return SizedBox(
      height: 48,
      child: Align(
        alignment: Alignment.centerRight,
        child: currentStep is OnboardingInfoStep
            ? Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: AppButton.ghost(
                  text: context.tr('onb_skip'),
                  onTap: vm.skip,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildStep(
    OnboardingStep step,
    OnboardingState state,
    OnboardingViewModel vm,
  ) {
    return switch (step) {
      OnboardingInfoStep() => OnboardingInfoStepView(step: step),
      OnboardingQuestionStep() => OnboardingQuestionStepView(
          step: step,
          selectedValue: state.answers[step.key],
          onSelect: (value) => vm.selectAnswer(step.key, value),
        ),
      OnboardingPermissionStep() => OnboardingPermissionStepView(step: step),
    };
  }

  Widget _buildBottomBar(
    OnboardingViewModel vm,
    OnboardingState state,
    int stepCount,
  ) {
    final isPermission = vm.currentStep is OnboardingPermissionStep;
    final primaryLabel = isPermission
        ? context.tr('onb_allow')
        : (vm.isLastStep ? context.tr('onb_finish') : context.tr('onb_next'));

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnboardingDots(count: stepCount, activeIndex: state.currentIndex),
          AppSpacing.gapLg,
          Row(
            children: [
              if (!vm.isFirstStep) ...[
                Expanded(
                  child: AppButton.outlined(
                    text: context.tr('onb_back'),
                    onTap: vm.back,
                  ),
                ),
                AppSpacing.gapHorizontalMd,
              ],
              Expanded(
                flex: 2,
                child: AppButton(
                  text: primaryLabel,
                  isDisabled: !vm.canAdvance,
                  onTap: () => _onPrimary(vm),
                ),
              ),
            ],
          ),
          if (isPermission) ...[
            AppSpacing.gapSm,
            AppButton.ghost(
              text: context.tr('onb_later'),
              expand: true,
              onTap: vm.next,
            ),
          ],
        ],
      ),
    );
  }
}
