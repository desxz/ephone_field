import 'package:ephone_field/ephone_field.dart';
import 'package:ephone_field/src/components/country_card.dart';
import 'package:ephone_field/src/components/country_picker_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/email_phone_textfield.dart';
import 'utils/caller_checker.dart';

void main() {
  setUp(EphoneFieldCallerChecker.reset);

  testWidgets('clears validation error when user edits after failed validate',
      (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      EPhoneFieldMock(
        formKey: formKey,
        emptyErrorText: EphoneFieldCallerChecker.mockEmptyError,
        emailValidator: EphoneFieldCallerChecker.mockEmailValidator,
        phoneValidator: EphoneFieldCallerChecker.mockPhoneValidator,
      ),
    );

    formKey.currentState!.validate();
    await tester.pump();
    expect(find.text(EphoneFieldCallerChecker.mockEmptyError), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'a');
    await tester.pump();

    expect(find.text(EphoneFieldCallerChecker.mockEmptyError), findsNothing);
  });

  testWidgets('keeps validation error when clearErrorOnChange is false',
      (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: EPhoneField(
              clearErrorOnChange: false,
              labels: EPhoneFieldLabels(
                emptyErrorText: EphoneFieldCallerChecker.mockEmptyError,
              ),
              emailValidator: EphoneFieldCallerChecker.mockEmailValidator,
              phoneValidator: EphoneFieldCallerChecker.mockPhoneValidator,
            ),
          ),
        ),
      ),
    );

    formKey.currentState!.validate();
    await tester.pump();
    expect(find.text(EphoneFieldCallerChecker.mockEmptyError), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'a');
    await tester.pump();

    expect(find.text(EphoneFieldCallerChecker.mockEmptyError), findsOneWidget);
  });

  testWidgets(
      'clears validation error when country changes after failed validate',
      (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: EPhoneField(
              labels: EPhoneFieldLabels(
                emptyErrorText: EphoneFieldCallerChecker.mockEmptyError,
              ),
              emailValidator: EphoneFieldCallerChecker.mockEmailValidator,
              phoneValidator: EphoneFieldCallerChecker.mockPhoneValidator,
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), '5');
    await tester.pump();
    formKey.currentState!.validate();
    await tester.pump();
    expect(find.text(EphoneFieldCallerChecker.mockPhoneValidatorError),
        findsOneWidget);

    await tester.tap(find.byType(CountryPickerButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CountryCard).first);
    await tester.pumpAndSettle();

    expect(find.text(EphoneFieldCallerChecker.mockPhoneValidatorError),
        findsNothing);
  });
}
