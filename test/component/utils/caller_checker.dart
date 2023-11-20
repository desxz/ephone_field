import 'package:ephone_field/ephone_field.dart';

class EphoneFieldCallerChecker {
  static bool isEmailValidatorCalled = false;
  static bool isPhoneValidatorCalled = false;
  static bool isOnValuePickedCalled = false;
  static bool isOnChangedCalled = false;
  static bool isOnCountryChangedCalled = false;

  static void reset() {
    isEmailValidatorCalled = false;
    isPhoneValidatorCalled = false;
    isOnValuePickedCalled = false;
    isOnChangedCalled = false;
    isOnCountryChangedCalled = false;
  }

  static String? mockEmailValidator(String? value) {
    isEmailValidatorCalled = true;
    return null;
  }

  static String? mockPhoneValidator(String? value) {
    isPhoneValidatorCalled = true;
    return null;
  }

  static void mockOnValuePicked(Country? value) {
    isOnValuePickedCalled = true;
  }

  static void mockOnChanged(String value) {
    isOnChangedCalled = true;
  }

  static void mockOnCountryChanged(Country value) {
    isOnCountryChangedCalled = true;
  }
}
