import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/localization/app_localizations.dart';
import 'package:phicore/core/localization/locale_provider.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/service/navigation_service.dart';
import 'package:phicore/core/services/auth/auth_service.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_radius.dart';
import 'package:phicore/core/theme/app_spacing.dart';
import 'package:phicore/core/widgets/app_button.dart';
import 'package:phicore/core/widgets/app_card.dart';

class ProfileTabView extends ConsumerWidget {
  const ProfileTabView({super.key});

  /// Locale dil koduna karşılık gelen çeviri key'i.
  String _languageLabelKey(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'english';
      case 'tr':
      default:
        return 'turkish';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return SafeArea(
      child: Padding(
        padding: AppSpacing.paddingXl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.gapLg,
            Text(
              context.tr('profile'),
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
                context.tr('username'),
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: Text(
                context.tr('user_email'),
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.grey50,
                ),
              ),
            ),
            AppSpacing.gapXxl,

            // Ayarlar kartı
            _ProfileCard(
              icon: Icons.settings_outlined,
              label: context.tr('settings'),
              onTap: () {},
            ),
            AppSpacing.gapSm,

            // Dil değiştirme kartı
            _ProfileCard(
              icon: Icons.language_outlined,
              label: context.tr('language'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.tr(_languageLabelKey(locale)),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey50,
                    ),
                  ),
                  AppSpacing.gapHorizontalSm,
                  const Icon(Icons.chevron_right,
                      size: 20, color: AppColors.grey50),
                ],
              ),
              onTap: () => _showLanguagePicker(context, ref),
            ),
            AppSpacing.gapSm,

            // Yardım kartı
            _ProfileCard(
              icon: Icons.help_outline,
              label: context.tr('help'),
              onTap: () {},
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
                text: context.tr('sign_out'),
                prefixIcon: const Icon(Icons.logout, size: 20),
              ),
            ),
            AppSpacing.gapLg,
          ],
        ),
      ),
    );
  }

  /// Dil seçim bottom sheet'ini açar.
  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final current = ref.read(localeProvider);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceLight : AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: AppSpacing.paddingXl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sheetContext.tr('language'),
                  style: sheetContext.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppSpacing.gapLg,
                for (final locale in AppLocalizations.supportedLocales)
                  _LanguageOption(
                    label: sheetContext.tr(_languageLabelKey(locale)),
                    selected: locale.languageCode == current.languageCode,
                    onTap: () {
                      ref.read(localeProvider.notifier).setLocale(locale);
                      Navigator.of(sheetContext).pop();
                    },
                  ),
                AppSpacing.gapSm,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Profil ayar kartı satırı.
class _ProfileCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback onTap;

  const _ProfileCard({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.grey70),
          AppSpacing.gapHorizontalMd,
          Expanded(
            child: Text(
              label,
              style: context.textTheme.bodyMedium,
            ),
          ),
          trailing ??
              const Icon(Icons.chevron_right,
                  size: 20, color: AppColors.grey50),
        ],
      ),
    );
  }
}

/// Bottom sheet içindeki tek dil seçeneği.
class _LanguageOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.mdBorder,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (selected)
              const Icon(Icons.check, size: 20, color: AppColors.grey90),
          ],
        ),
      ),
    );
  }
}
