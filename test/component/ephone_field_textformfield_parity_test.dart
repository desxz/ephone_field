import 'package:ephone_field/ephone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('validator resolves field type from value not stale build type', (
    tester,
  ) async {
    final key = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: key,
            child: const EPhoneField(
              initialType: EphoneFieldType.initial,
              labels: EPhoneFieldLabels(emptyErrorText: 'Required'),
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'not-an-email');
    await tester.pump();

    expect(key.currentState!.validate(), isFalse);
  });

  testWidgets('phone mode disables autocorrect by default', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: EPhoneField(initialType: EphoneFieldType.phone)),
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.autocorrect, isFalse);
    expect(textField.enableSuggestions, isFalse);
    expect(textField.smartDashesType, SmartDashesType.disabled);
    expect(textField.smartQuotesType, SmartQuotesType.disabled);
  });

  testWidgets('email mode enables suggestions by default', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: EPhoneField(initialType: EphoneFieldType.email)),
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.autocorrect, isTrue);
    expect(textField.enableSuggestions, isTrue);
  });
}
