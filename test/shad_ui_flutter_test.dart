import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shad_ui_flutter/shad_ui_flutter.dart';

void main() {
  testWidgets('Shad UI Flutter smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ShadTheme(
        data: ShadThemeData.light(),
        child: MaterialApp(
          home: Scaffold(
            body: ShadButton(onPressed: () {}, child: Text('Test Button')),
          ),
        ),
      ),
    );

    // Verify that our button is displayed
    expect(find.text('Test Button'), findsOneWidget);
  });
}
