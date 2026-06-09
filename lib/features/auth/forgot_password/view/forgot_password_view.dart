import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/extensions/context_extensions.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_spacing.dart';
import 'package:phicore/core/utils/validators.dart';
import 'package:phicore/core/widgets/app_button.dart';
import 'package:phicore/core/widgets/app_snackbar.dart';
import 'package:phicore/core/widgets/app_text_field.dart';
import 'package:phicore/features/auth/forgot_password/view_model/forgot_password_view_model.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ForgotPasswordView> createState() =>
      _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    context.unfocus();

    ref.read(forgotPasswordViewModelProvider.notifier).sendResetEmail(
          email: _emailController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordViewModelProvider);
    final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);
    final isSuccess =
        state.maybeWhen(loaded: (_) => true, orElse: () => false);

    ref.listen(forgotPasswordViewModelProvider, (prev, next) {
      next.maybeWhen(
        loaded: (_) => AppSnackbar.success(
          context,
          message: 'Şifre sıfırlama bağlantısı email adresinize gönderildi',
        ),
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
        title: const Text('Şifremi Unuttum'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.paddingXl,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // İkon
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.lock_reset_outlined,
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  AppSpacing.gapXl,

                  // Başlık
                  Text(
                    'Şifrenizi mi unuttunuz?',
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppSpacing.gapSm,
                  Text(
                    'Email adresinizi girin, size şifre sıfırlama bağlantısı gönderelim.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.grey50,
                    ),
                  ),
                  AppSpacing.gapXxl,

                  // Email
                  AppTextField(
                    controller: _emailController,
                    label: 'Email',
                    hintText: 'ornek@email.com',
                    prefixIcon: const Icon(Icons.email_outlined, size: 20),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _onSubmit(),
                    validator: Validators.email,
                    enabled: !isSuccess,
                  ),
                  AppSpacing.gapXl,

                  // Gönder Butonu
                  SizedBox(
                    width: double.infinity,
                    child: isSuccess
                        ? AppButton.outlined(
                            onTap: () => context.pop(),
                            text: 'Giriş Ekranına Dön',
                          )
                        : AppButton(
                            onTap: isLoading ? null : _onSubmit,
                            text: 'Bağlantı Gönder',
                            isLoading: isLoading,
                          ),
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
