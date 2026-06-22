import 'package:flutter/material.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/localization/app_localizations.dart';
import 'package:phicore/core/theme/app_spacing.dart';
import 'package:phicore/features/onboarding/data/model/onboarding_step.dart';
import 'package:phicore/features/onboarding/view/widgets/onboarding_option_card.dart';

/// Tek seçimli onboarding sorusu.
class OnboardingQuestionStepView extends StatelessWidget {
  final OnboardingQuestionStep step;
  final String? selectedValue;
  final ValueChanged<String> onSelect;

  const OnboardingQuestionStepView({
    super.key,
    required this.step,
    required this.selectedValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.horizontalXl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.gapXl,
          Text(
            context.tr(step.questionKey),
            style: context.textTheme.headlineLarge,
          ),
          AppSpacing.gapSm,
          Text(
            context.tr('onb_personalize_hint'),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
          AppSpacing.gapXl,
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              itemCount: step.options.length,
              separatorBuilder: (_, _) => AppSpacing.gapMd,
              itemBuilder: (context, index) {
                final option = step.options[index];
                return OnboardingOptionCard(
                  label: context.tr(option.labelKey),
                  icon: option.icon,
                  isSelected: selectedValue == option.value,
                  onTap: () => onSelect(option.value),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
