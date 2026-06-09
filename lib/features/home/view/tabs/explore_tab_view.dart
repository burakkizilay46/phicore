import 'package:flutter/material.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_spacing.dart';

class ExploreTabView extends StatelessWidget {
  const ExploreTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppSpacing.paddingXl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.gapLg,
            Text(
              'Keşfet',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            AppSpacing.gapSm,
            Text(
              'Keşfet sayfası placeholder. Gerçek feature ile değiştirilecek.',
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.grey50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
