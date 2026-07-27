import 'package:ephone_field/ephone_field.dart';

/// Optional built-in validators for [EPhoneField].
abstract final class EphoneFieldValidators {
  /// Validates a basic email shape.
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailPattern.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// Validates phone length against [country] constraints.
  static String? Function(String?) phone(Country country) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Phone number is required';
      }
      final digits = value.replaceAll(RegExp(r'\D'), '');
      final nationalLength = digits.length - country.dialCode.toString().length;
      if (nationalLength < country.minLength ||
          nationalLength > country.maxLength) {
        return 'Enter a valid phone number';
      }
      return null;
    };
  }
}
