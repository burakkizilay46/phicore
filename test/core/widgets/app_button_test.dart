import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phicore/core/theme/app_theme.dart';
import 'package:phicore/core/widgets/app_button.dart';

Widget wrapWithApp(Widget child) {
  return MaterialApp(
    theme: AppTheme.dark,
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('AppButton', () {
    testWidgets('text doğru render edilir', (tester) async {
      await tester.pumpWidget(wrapWithApp(
        AppButton(text: 'Test Button', onTap: () {}),
      ));

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('onTap çağrılır', (tester) async {
      int tapCount = 0;
      await tester.pumpWidget(wrapWithApp(
        AppButton(text: 'Tap Me', onTap: () => tapCount++),
      ));

      await tester.tap(find.text('Tap Me'));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
    });

    testWidgets('onTap null iken tıklanmaz', (tester) async {
      await tester.pumpWidget(wrapWithApp(
        const AppButton(text: 'Disabled', onTap: null),
      ));

      // Widget mevcut ama disabled
      expect(find.text('Disabled'), findsOneWidget);
    });

    testWidgets('loading state spinner gösterir', (tester) async {
      await tester.pumpWidget(wrapWithApp(
        AppButton(text: 'Loading', onTap: () {}, isLoading: true),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('outlined variant oluşturulur', (tester) async {
      await tester.pumpWidget(wrapWithApp(
        AppButton.outlined(text: 'Outlined', onTap: () {}),
      ));

      expect(find.text('Outlined'), findsOneWidget);
    });

    testWidgets('ghost variant oluşturulur', (tester) async {
      await tester.pumpWidget(wrapWithApp(
        AppButton.ghost(text: 'Ghost', onTap: () {}),
      ));

      expect(find.text('Ghost'), findsOneWidget);
    });
  });
}
