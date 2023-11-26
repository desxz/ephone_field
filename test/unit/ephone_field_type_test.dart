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
        EphoneFieldType.phone.inputFormatters(Country.unitedStates, true, " ").length,
        2,
      );
      expect(
        EphoneFieldType.phone.inputFormatters(Country.unitedStates, false, "").length,
        2,
      );
      expect(
        EphoneFieldType.initial.inputFormatters(Country.unitedStates, true, " "),
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

  test(
    'should email validator works successfully',
    () {
      final String? Function(String?)? emailValidator = EphoneFieldType.email.validator(
        (value) => value == "email" ? null : "error",
        Country.unitedStates,
        "",
      );

      expect(emailValidator!("email"), null);
      expect(emailValidator(""), "error");
    },
  );

  test(
    'should phone validator works successfully',
    () {
      final String? Function(String?)? phoneValidator = EphoneFieldType.phone.validator(
        (value) => value == "+1222333" ? null : "error",
        Country.unitedStates,
        " ",
      );

      expect(phoneValidator!("222 333"), null);
      expect(phoneValidator(""), "error");
    },
  );

  test('should empty validator works successfully', () {
    final String? Function(String?)? emptyValidator = EphoneFieldType.initial.validator(
      (value) => value == "empty" ? null : "error",
      Country.unitedStates,
      "",
    );

    expect(emptyValidator!("empty"), null);
    expect(emptyValidator(""), "error");
  });
}
