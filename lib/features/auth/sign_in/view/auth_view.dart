import 'package:flutter/material.dart';
import 'package:phicore/core/widgets/app_button.dart';
import 'package:phicore/core/widgets/app_text_field.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextField(label: 'Email'),
            SizedBox(height: 12),
            AppTextField(label: "Password"),
            SizedBox(height: 12),
            SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width - 24,
              child: AppButton(onTap: () {}, buttonText: 'Sign in'),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Do you have not an account?'),
            ),
          ],
        ),
      ),
    );
  }
}
