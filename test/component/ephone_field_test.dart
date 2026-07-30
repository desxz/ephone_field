import 'package:ephone_field/ephone_field.dart';
import 'package:ephone_field/src/components/country_picker_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/email_phone_textfield.dart';
import 'utils/caller_checker.dart';

Widget buildEphoneFieldTestApp({
  required GlobalKey<FormState> formKey,
  TextEditingController? controller,
  String? initialValue,
  bool isSearchable = true,
  void Function(String)? onChanged,
  void Function(String?)? onSaved,
}) {
  return EPhoneFieldMock(
    formKey: formKey,
    controller: controller,
    initialValue: initialValue,
    isSearchable: isSearchable,
    emptyErrorText: EphoneFieldCallerChecker.mockEmptyError,
    emailValidator: EphoneFieldCallerChecker.mockEmailValidator,
    phoneValidator: EphoneFieldCallerChecker.mockPhoneValidator,
    onChanged: onChanged ?? EphoneFieldCallerChecker.mockOnChanged,
    onCountryChanged: EphoneFieldCallerChecker.mockOnCountryChanged,
    onSaved: onSaved ?? EphoneFieldCallerChecker.mockOnSaved,
    onFieldSubmitted: EphoneFieldCallerChecker.mockOnFieldSubmitted,
  );
}

void main() {
  setUp(EphoneFieldCallerChecker.reset);

  testWidgets('renders successfully', (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(buildEphoneFieldTestApp(formKey: formKey));
    expect(find.byType(EPhoneField), findsOneWidget);
    expect(find.text('Email or phone number'), findsOneWidget);
  });

  testWidgets('switches to email mode when @ is entered', (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(buildEphoneFieldTestApp(formKey: formKey));

    await tester.enterText(find.byType(TextFormField), '@');
    await tester.pump();

    expect(find.text('Email'), findsOneWidget);
    expect(find.byType(CountryPickerButton), findsNothing);
  });

  testWidgets('switches to phone mode when digits are entered', (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(buildEphoneFieldTestApp(formKey: formKey));

    await tester.enterText(find.byType(TextFormField), '1');
    await tester.pump();

    expect(find.text('Phone number'), findsOneWidget);
    expect(find.byType(CountryPickerButton), findsOneWidget);
  });

  testWidgets('uses initialValue when no controller is provided', (
    tester,
  ) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      buildEphoneFieldTestApp(
        formKey: formKey,
        initialValue: 'test@example.com',
      ),
    );

    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
  });

  testWidgets('empty validator is called for empty input', (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(buildEphoneFieldTestApp(formKey: formKey));

    formKey.currentState!.validate();
    await tester.pump();

    expect(find.text(EphoneFieldCallerChecker.mockEmptyError), findsOneWidget);
  });

  testWidgets('email validator is called for invalid email', (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(buildEphoneFieldTestApp(formKey: formKey));

    await tester.enterText(find.byType(TextFormField), 'invalidmail');
    await tester.pump();
    formKey.currentState!.validate();
    await tester.pump();

    expect(EphoneFieldCallerChecker.isEmailValidatorCalled, isTrue);
    expect(
      find.text(EphoneFieldCallerChecker.mockEmailValidatorError),
      findsOneWidget,
    );
  });

  testWidgets('phone onChanged receives national display text', (tester) async {
    final formKey = GlobalKey<FormState>();
    String? changedValue;
    await tester.pumpWidget(
      buildEphoneFieldTestApp(
        formKey: formKey,
        onChanged: (value) => changedValue = value,
      ),
    );

    await tester.enterText(find.byType(TextFormField), '5551234567');
    await tester.pump();

    expect(changedValue, isNotNull);
    expect(changedValue!.replaceAll(RegExp(r'\D'), ''), '5551234567');
  });

  testWidgets('phone onSaved maps to international number', (tester) async {
    final formKey = GlobalKey<FormState>();
    String? savedValue;
    await tester.pumpWidget(
      buildEphoneFieldTestApp(
        formKey: formKey,
        onSaved: (value) => savedValue = value,
      ),
    );

    await tester.enterText(find.byType(TextFormField), '5551234567');
    await tester.pump();
    formKey.currentState!.save();

    expect(savedValue, '+15551234567');
  });

  testWidgets('onCountryChanged is called when a country is selected', (
    tester,
  ) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(buildEphoneFieldTestApp(formKey: formKey));

    await tester.enterText(find.byType(TextFormField), '1');
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CountryPickerButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Afghanistan'));
    await tester.pumpAndSettle();

    expect(EphoneFieldCallerChecker.isOnCountryChangedCalled, isTrue);
  });
}
