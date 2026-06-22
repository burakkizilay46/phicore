import 'package:flutter/material.dart';
import 'package:phicore/core/constants/app_constants.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/theme/app_radius.dart';

/// Onboarding sayfa göstergesi (animasyonlu noktalar) — tema uyumlu.
class OnboardingDots extends StatelessWidget {
  final int count;
  final int activeIndex;

  const OnboardingDots({
    super.key,
    required this.count,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: AppConstants.animNormal,
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 6,
          width: isActive ? 22 : 6,
          decoration: BoxDecoration(
            color: isActive ? colorScheme.primary : colorScheme.outline,
            borderRadius: AppRadius.fullBorder,
          ),
        );
      }),
    );
  }
}
