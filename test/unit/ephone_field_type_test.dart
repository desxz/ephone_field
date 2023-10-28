import 'package:ephone_field/ephone_field.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should EPhoneTextFieldType keyboardType match successfully', () {
    expect(EPhoneTextFieldType.email.keyboardType, TextInputType.emailAddress);
    expect(EPhoneTextFieldType.phone.keyboardType, TextInputType.phone);
    expect(EPhoneTextFieldType.initial.keyboardType, TextInputType.text);
  });

  test(
    'should EPhoneTextFieldType inputFormatters match successfully',
    () {
      expect(
        EPhoneTextFieldType.email
            .inputFormatters(Country.unitedStates, true, " "),
        [],
      );
      expect(
        EPhoneTextFieldType.phone
            .inputFormatters(Country.unitedStates, true, " ")
            .length,
        2,
      );
      expect(
        EPhoneTextFieldType.phone
            .inputFormatters(Country.unitedStates, false, "")
            .length,
        2,
      );
      expect(
        EPhoneTextFieldType.initial
            .inputFormatters(Country.unitedStates, true, " "),
        [],
      );
    },
  );

  test(
    'should EPhoneTextFieldType labelText match successfully',
    () {
      expect(
        EPhoneTextFieldType.email.labelText("empty", "email", "phone"),
        "email",
      );
      expect(
        EPhoneTextFieldType.phone.labelText("empty", "email", "phone"),
        "phone",
      );
      expect(
        EPhoneTextFieldType.initial.labelText("empty", "email", "phone"),
        "empty",
      );
    },
  );
}
