import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/localization/app_localizations.dart';
import 'package:phicore/core/navigation/navigation_constants.dart';
import 'package:phicore/core/navigation/service/navigation_service.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_spacing.dart';
import 'package:phicore/core/utils/validators.dart';
import 'package:phicore/core/widgets/app_button.dart';
import 'package:phicore/core/widgets/app_snackbar.dart';
import 'package:phicore/core/widgets/app_text_field.dart';
import 'package:phicore/features/auth/sign_in/view_model/auth_view_model.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    if (!_formKey.currentState!.validate()) return;
    context.unfocus();

    ref.read(authViewModelProvider.notifier).signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);
    final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);

    ref.listen(authViewModelProvider, (prev, next) {
      next.maybeWhen(
        error: (message) => AppSnackbar.error(context, message: message),
        orElse: () {},
      );
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.paddingXl,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Image.asset(
                    'assets/logo/phicore_logo_transparent.png',
                    height: 120,
                  ),
                  AppSpacing.gapXl,

                  // Başlık
                  Text(
                    context.tr('welcome'),
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppSpacing.gapXs,
                  Text(
                    context.tr('sign_in_subtitle'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.grey50,
                    ),
                  ),
                  AppSpacing.gapXxl,

                  // Email
                  AppTextField(
                    controller: _emailController,
                    label: context.tr('email'),
                    hintText: context.tr('email_hint'),
                    prefixIcon: const Icon(Icons.email_outlined, size: 20),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: Validators.email,
                  ),
                  AppSpacing.gapMd,

                  // Şifre
                  AppTextField(
                    controller: _passwordController,
                    label: context.tr('password'),
                    hintText: context.tr('password_hint'),
                    prefixIcon: const Icon(Icons.lock_outline, size: 20),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _onSignIn(),
                    validator: Validators.password,
                  ),
                  AppSpacing.gapSm,

                  // Şifremi Unuttum
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        NavigationService.instance.navigateToPage(
                          path: NavigationConstants.forgotPassword,
                        );
                      },
                      child: Text(
                        context.tr('forgot_password'),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.grey70,
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.gapLg,

                  // Giriş Butonu
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      onTap: isLoading ? null : _onSignIn,
                      text: context.tr('sign_in'),
                      isLoading: isLoading,
                    ),
                  ),
                  AppSpacing.gapLg,

                  // Ayraç ("veya")
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          context.tr('or'),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.grey50,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  AppSpacing.gapLg,

                  // Google ile devam et
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      onTap: isLoading
                          ? null
                          : () => ref
                              .read(authViewModelProvider.notifier)
                              .signInWithGoogle(),
                      text: context.tr('continue_with_google'),
                      variant: AppButtonVariant.outlined,
                      // TODO: Resmi Google logosu için bir asset ile değiştirilebilir.
                      prefixIcon: const Icon(Icons.g_mobiledata, size: 26),
                    ),
                  ),

                  // Apple ile devam et (yalnız iOS)
                  if (Platform.isIOS) ...[
                    AppSpacing.gapMd,
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        onTap: isLoading
                            ? null
                            : () => ref
                                .read(authViewModelProvider.notifier)
                                .signInWithApple(),
                        text: context.tr('continue_with_apple'),
                        variant: AppButtonVariant.outlined,
                        prefixIcon: const Icon(Icons.apple, size: 20),
                      ),
                    ),
                  ],
                  AppSpacing.gapLg,

                  // Kayıt ol linki
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.tr('no_account'),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.grey50,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          NavigationService.instance.navigateToPage(
                            path: NavigationConstants.register,
                          );
                        },
                        child: Text(
                          context.tr('sign_up'),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
