import 'package:ephone_field/ephone_field.dart';

class EphoneFieldCallerChecker {
  static bool isEmailValidatorCalled = false;
  static bool isPhoneValidatorCalled = false;
  static bool isOnValuePickedCalled = false;
  static bool isOnChangedCalled = false;
  static bool isOnCountryChangedCalled = false;
  static bool isOnSavedCalled = false;
  static bool isOnFieldSubmittedCalled = false;

  static String mockEmptyError = 'Field cannot be empty';
  static String mockEmailValidatorError = 'Invalid email address';
  static String mockPhoneValidatorError = 'Invalid phone number';

  static void reset() {
    isEmailValidatorCalled = false;
    isPhoneValidatorCalled = false;
    isOnValuePickedCalled = false;
    isOnChangedCalled = false;
    isOnCountryChangedCalled = false;
    isOnSavedCalled = false;
    isOnFieldSubmittedCalled = false;
  }

  static String? mockEmailValidator(String? value) {
    isEmailValidatorCalled = true;
    if (!value!.contains('@')) return mockEmailValidatorError;
    return null;
  }

  static String? mockPhoneValidator(String? value) {
    isPhoneValidatorCalled = true;
    if (value!.length < 6) return mockPhoneValidatorError;
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

  static void mockOnSaved(String? value) {
    isOnSavedCalled = true;
  }

  static void mockOnFieldSubmitted(String? value) {
    isOnFieldSubmittedCalled = true;
  }
}
