import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/localization/app_localizations.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_spacing.dart';
import 'package:phicore/core/utils/validators.dart';
import 'package:phicore/core/widgets/app_button.dart';
import 'package:phicore/core/widgets/app_snackbar.dart';
import 'package:phicore/core/widgets/app_text_field.dart';
import 'package:phicore/features/auth/register/view_model/register_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (!_formKey.currentState!.validate()) return;
    context.unfocus();

    ref
        .read(registerViewModelProvider.notifier)
        .register(
          name: _nameController.text.trim(),
          surname: _surnameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerViewModelProvider);
    final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);

    ref.listen(registerViewModelProvider, (prev, next) {
      next.maybeWhen(
        error: (message) => AppSnackbar.error(context, message: message),
        orElse: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: Text(context.tr('sign_up')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingXl,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.gapLg,

                // Başlık
                Text(
                  context.tr('create_account'),
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppSpacing.gapXs,
                Text(
                  context.tr('register_subtitle'),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey50,
                  ),
                ),
                AppSpacing.gapXxl,

                // Ad - Soyad yan yana
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _nameController,
                        label: context.tr('name'),
                        hintText: context.tr('name_hint'),
                        prefixIcon: const Icon(Icons.person_outline, size: 20),
                        textInputAction: TextInputAction.next,
                        validator: Validators.name,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppTextField(
                        controller: _surnameController,
                        label: context.tr('surname'),
                        hintText: context.tr('surname_hint'),
                        textInputAction: TextInputAction.next,
                        validator: Validators.name,
                      ),
                    ),
                  ],
                ),
                AppSpacing.gapMd,

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
                  textInputAction: TextInputAction.next,
                  validator: Validators.password,
                ),
                AppSpacing.gapMd,

                // Şifre Tekrar
                AppTextField(
                  controller: _confirmPasswordController,
                  label: context.tr('confirm_password'),
                  hintText: context.tr('password_hint'),
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _onRegister(),
                  validator: Validators.confirmPassword(
                    _passwordController.text,
                  ),
                ),
                AppSpacing.gapXl,

                // Kayıt Ol Butonu
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    onTap: isLoading ? null : _onRegister,
                    text: context.tr('sign_up'),
                    isLoading: isLoading,
                  ),
                ),
                AppSpacing.gapLg,

                // Giriş yap linki
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.tr('has_account'),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey50,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        context.tr('sign_in'),
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
    );
  }
}
