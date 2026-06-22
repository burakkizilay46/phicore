import 'package:flutter/material.dart';
import 'package:phicore/core/constants/app_constants.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/theme/app_radius.dart';
import 'package:phicore/core/theme/app_spacing.dart';

/// Onboarding sorularında kullanılan seçilebilir kart.
///
/// Tema uyumlu: seçiliyken kenarlık ve metin [ColorScheme.primary]'e döner ve
/// bir onay ikonu belirir. Açık/koyu temada doğru kontrastı korur.
class OnboardingOptionCard extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  const OnboardingOptionCard({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final selectedColor = colorScheme.primary;
    final mutedColor = colorScheme.onSurface.withValues(alpha: 0.6);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppConstants.animFast,
        curve: Curves.easeInOut,
        padding: AppSpacing.paddingLg,
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor.withValues(alpha: 0.06)
              : Colors.transparent,
          borderRadius: AppRadius.lgBorder,
          border: Border.all(
            color: isSelected ? selectedColor : colorScheme.outline,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 22,
                color: isSelected ? selectedColor : mutedColor,
              ),
              AppSpacing.gapHorizontalMd,
            ],
            Expanded(
              child: Text(
                label,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: isSelected
                      ? colorScheme.onSurface
                      : colorScheme.onSurface.withValues(alpha: 0.85),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            AnimatedScale(
              duration: AppConstants.animFast,
              scale: isSelected ? 1 : 0,
              child: Icon(
                Icons.check_circle,
                size: 22,
                color: selectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
