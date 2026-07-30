import 'package:ephone_field/ephone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fake_phone_number_service.dart';

void main() {
  testWidgets('defaults validate email when validators omitted', (
    tester,
  ) async {
    final key = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: key,
            child: EPhoneField(
              initialType: EphoneFieldType.email,
              initialValue: 'not-email',
            ),
          ),
        ),
      ),
    );

    expect(key.currentState!.validate(), isFalse);
  });

  testWidgets('compose phone blocks number without PhoneNumberService API', (
    tester,
  ) async {
    final service = FakePhoneNumberService(
      validNumbers: {'TR|55544445544', 'TR|9055544445544'},
    );
    final key = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: key,
            child: EPhoneField(
              debugPhoneNumberService: service,
              initialType: EphoneFieldType.phone,
              initialCountry: Country.turkey,
              initialValue: '55544445544',
              phoneValidator: Validators.compose([
                PhoneValidators.phone,
                (value) {
                  final digits = value?.replaceAll(RegExp(r'\D'), '') ?? '';
                  if (digits.endsWith('55544445544')) {
                    return 'This number is not allowed';
                  }
                  return null;
                },
              ]),
            ),
          ),
        ),
      ),
    );

    expect(key.currentState!.validate(), isFalse);
    await tester.pump();
    expect(find.text('This number is not allowed'), findsOneWidget);
  });

  testWidgets('binding uses selected country for PhoneValidators.phone', (
    tester,
  ) async {
    final service = FakePhoneNumberService(
      // Field text and dial-prefixed callback forms both appear in validation.
      validNumbers: {'US|4155552671', 'US|14155552671'},
    );
    final key = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: key,
            child: EPhoneField(
              debugPhoneNumberService: service,
              initialType: EphoneFieldType.phone,
              initialCountry: Country.unitedStates,
              initialValue: '4155552671',
            ),
          ),
        ),
      ),
    );

    expect(key.currentState!.validate(), isTrue);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: key,
            child: EPhoneField(
              debugPhoneNumberService: service,
              initialType: EphoneFieldType.phone,
              initialCountry: Country.turkey,
              initialValue: '4155552671',
            ),
          ),
        ),
      ),
    );

    // Same national digits are not in Fake valid set for TR, and TR length
    // path is not used because Fake is not Unsupported — isValid false.
    expect(key.currentState!.validate(), isFalse);
  });
}
