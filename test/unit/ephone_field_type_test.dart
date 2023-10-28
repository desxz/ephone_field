import 'package:ephone_field/ephone_field.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should EphoneFieldType keyboardType match successfully', () {
    expect(EphoneFieldType.email.keyboardType, TextInputType.emailAddress);
    expect(EphoneFieldType.phone.keyboardType, TextInputType.phone);
    expect(EphoneFieldType.initial.keyboardType, TextInputType.text);
  });

  test(
    'should EphoneFieldType inputFormatters match successfully',
    () {
      expect(
        EphoneFieldType.email.inputFormatters(Country.unitedStates, true, " "),
        [],
      );
      expect(
        EphoneFieldType.phone
            .inputFormatters(Country.unitedStates, true, " ")
            .length,
        2,
      );
      expect(
        EphoneFieldType.phone
            .inputFormatters(Country.unitedStates, false, "")
            .length,
        2,
      );
      expect(
        EphoneFieldType.initial
            .inputFormatters(Country.unitedStates, true, " "),
        [],
      );
    },
  );

  test(
    'should EphoneFieldType labelText match successfully',
    () {
      expect(
        EphoneFieldType.email.labelText("empty", "email", "phone"),
        "email",
      );
      expect(
        EphoneFieldType.phone.labelText("empty", "email", "phone"),
        "phone",
      );
      expect(
        EphoneFieldType.initial.labelText("empty", "email", "phone"),
        "empty",
      );
    },
  );
}
