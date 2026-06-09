import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phicore/core/theme/app_theme.dart';
import 'package:phicore/core/widgets/app_text_field.dart';

Widget wrapWithApp(Widget child) {
  return MaterialApp(
    theme: AppTheme.dark,
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('AppTextField', () {
    testWidgets('label doğru render edilir', (tester) async {
      await tester.pumpWidget(wrapWithApp(
        const AppTextField(label: 'Email'),
      ));

      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('controller ile text girilir', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(wrapWithApp(
        AppTextField(label: 'Test', controller: controller),
      ));

      await tester.enterText(find.byType(TextFormField), 'hello');
      expect(controller.text, 'hello');
    });

    testWidgets('validator hata mesajı gösterir', (tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(wrapWithApp(
        Form(
          key: formKey,
          child: AppTextField(
            label: 'Email',
            validator: (value) =>
                value == null || value.isEmpty ? 'Zorunlu alan' : null,
          ),
        ),
      ));

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text('Zorunlu alan'), findsOneWidget);
    });

    testWidgets('obscureText toggle çalışır', (tester) async {
      await tester.pumpWidget(wrapWithApp(
        const AppTextField(label: 'Şifre', obscureText: true),
      ));

      // _obscureVisible başlangıçta false → visibility_rounded gösterir
      final toggleFinder = find.byIcon(Icons.visibility_rounded);
      expect(toggleFinder, findsOneWidget);

      // Tıkla → _obscureVisible true → visibility_off_rounded gösterir
      await tester.tap(toggleFinder);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_off_rounded), findsOneWidget);
    });

    testWidgets('onChanged callback çalışır', (tester) async {
      String? changedValue;
      await tester.pumpWidget(wrapWithApp(
        AppTextField(
          label: 'Test',
          onChanged: (value) => changedValue = value,
        ),
      ));

      await tester.enterText(find.byType(TextFormField), 'typed');
      expect(changedValue, 'typed');
    });

    testWidgets('filled variant oluşturulur', (tester) async {
      await tester.pumpWidget(wrapWithApp(
        const AppTextField.filled(label: 'Filled'),
      ));

      expect(find.text('Filled'), findsOneWidget);
    });
  });
}
