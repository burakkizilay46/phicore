import 'package:flutter/material.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/localization/app_localizations.dart';
import 'package:phicore/core/theme/app_radius.dart';
import 'package:phicore/core/theme/app_spacing.dart';
import 'package:phicore/features/onboarding/data/model/onboarding_step.dart';

/// Bildirim izni hazırlık (soft-ask) adımı — yalnızca görsel.
///
/// "İzin Ver" / "Şimdi değil" butonları [OnboardingView]'in alt çubuğunda yer
/// alır. Gerçek sistem izni isteği orada TODO olarak bırakıldı (permission
/// paketi projede yok).
class OnboardingPermissionStepView extends StatelessWidget {
  final OnboardingPermissionStep step;

  const OnboardingPermissionStepView({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Padding(
      padding: AppSpacing.horizontalXl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 96,
            width: 96,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: AppRadius.fullBorder,
              border: Border.all(color: colorScheme.outline, width: 1),
            ),
            child: Icon(
              Icons.notifications_active_outlined,
              size: 44,
              color: colorScheme.onSurface,
            ),
          ),
          AppSpacing.gapXl,
          Text(
            context.tr(step.titleKey),
            style: context.textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          AppSpacing.gapMd,
          Text(
            context.tr(step.descriptionKey),
            style: context.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
