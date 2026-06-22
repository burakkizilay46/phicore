import 'package:flutter/material.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/localization/app_localizations.dart';
import 'package:phicore/core/theme/app_radius.dart';
import 'package:phicore/core/theme/app_spacing.dart';
import 'package:phicore/features/onboarding/data/model/onboarding_step.dart';

/// Karşılama / değer önerisi slaytı.
class OnboardingInfoStepView extends StatelessWidget {
  final OnboardingInfoStep step;

  const OnboardingInfoStepView({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Padding(
      padding: AppSpacing.horizontalXl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 88,
            width: 88,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: AppRadius.xlBorder,
              border: Border.all(color: colorScheme.outline, width: 1),
            ),
            child: Icon(step.icon, size: 40, color: colorScheme.onSurface),
          ),
          AppSpacing.gapXl,
          Text(
            context.tr(step.titleKey),
            style: context.textTheme.displayMedium,
          ),
          AppSpacing.gapMd,
          Text(
            context.tr(step.descriptionKey),
            style: context.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
