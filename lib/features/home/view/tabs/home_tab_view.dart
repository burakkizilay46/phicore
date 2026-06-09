import 'package:flutter/material.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_spacing.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppSpacing.paddingXl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.gapLg,
            Row(
              children: [
                Image.asset(
                  'assets/logo/phicore_logo_transparent.png',
                  height: 32,
                ),
                AppSpacing.gapHorizontalMd,
                Text(
                  'PhiCore',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            AppSpacing.gapXl,
            Text(
              'Hoş Geldiniz',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            AppSpacing.gapSm,
            Text(
              'Bu sayfa ana içerik alanıdır. Gerçek feature ile değiştirilecek.',
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
