import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/service/navigation_service.dart';
import 'package:phicore/core/services/auth/auth_service.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_spacing.dart';
import 'package:phicore/core/widgets/app_button.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.paddingXl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/logo/phicore_logo_transparent.png',
                height: 80,
              ),
              AppSpacing.gapXl,
              Text(
                'PhiCore',
                style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSpacing.gapSm,
              Text(
                'Başarıyla giriş yaptınız',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: AppColors.grey50,
                ),
              ),
              const Spacer(),
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
              AppSpacing.gapXl,
            ],
          ),
        ),
      ),
    );
  }
}
