import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:screen_ppi_getter/screen_ppi_getter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('e2e', () {
    testWidgets(
      'ppi is retrieved correctly',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(),
        );

        final plugin = ScreenPpiGetter();

        await expectLater(
          plugin.getScreenPpi(),
          completes,
        );
      },
    );
  });
}
