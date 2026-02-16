import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/features/splash/view_model/splash_view_model.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(splashViewModelProvider);
    return Scaffold(
      body: Center(
        child: FlutterLogo(size: MediaQuery.of(context).size.width / 2),
      ),
    );
  }
}
