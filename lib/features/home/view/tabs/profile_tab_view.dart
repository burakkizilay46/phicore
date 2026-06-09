import 'package:flutter/material.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/service/navigation_service.dart';
import 'package:phicore/core/services/auth/auth_service.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_spacing.dart';
import 'package:phicore/core/widgets/app_button.dart';
import 'package:phicore/core/widgets/app_card.dart';

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({super.key});

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
              'Profil',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            AppSpacing.gapXl,

            // Avatar placeholder
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.grey30,
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  size: 40,
                  color: AppColors.grey50,
                ),
              ),
            ),
            AppSpacing.gapMd,
            Center(
              child: Text(
                'Kullanıcı Adı',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: Text(
                'kullanici@email.com',
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.grey50,
                ),
              ),
            ),
            AppSpacing.gapXxl,

            // Ayarlar kartları
            AppCard(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(Icons.settings_outlined, size: 20, color: AppColors.grey70),
                  AppSpacing.gapHorizontalMd,
                  Expanded(
                    child: Text(
                      'Ayarlar',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                  const Icon(Icons.chevron_right, size: 20, color: AppColors.grey50),
                ],
              ),
            ),
            AppSpacing.gapSm,
            AppCard(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(Icons.help_outline, size: 20, color: AppColors.grey70),
                  AppSpacing.gapHorizontalMd,
                  Expanded(
                    child: Text(
                      'Yardım',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                  const Icon(Icons.chevron_right, size: 20, color: AppColors.grey50),
                ],
              ),
            ),

            const Spacer(),

            // Çıkış Yap
            SizedBox(
              width: double.infinity,
              child: AppButton.outlined(
                onTap: () async {
                  await AuthService().signOut();
                  NavigationService.instance.navigateToPageClear(
                    path: NavigationConstants.signIn,
                  );
                },
                text: 'Çıkış Yap',
                prefixIcon: const Icon(Icons.logout, size: 20),
              ),
            ),
            AppSpacing.gapLg,
          ],
        ),
      ),
    );
  }
}
