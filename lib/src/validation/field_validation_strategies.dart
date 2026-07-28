import 'package:flutter/widgets.dart';

import 'email_validators.dart';
import 'field_validation_strategy.dart';
import 'phone_validators.dart';

/// Initial (empty) mode: optional required message only.
class InitialValidationStrategy implements FieldValidationStrategy {
  /// Creates the initial-mode strategy.
  const InitialValidationStrategy();

  @override
  FormFieldValidator<String>? resolve({
    required FormFieldValidator<String>? userValidator,
    required ValidationContext context,
  }) {
    final message = context.emptyErrorText;
    if (message == null) {
      return null;
    }
    return (value) => value == null || value.isEmpty ? message : null;
  }
}

/// Email mode: user override or [EmailValidators.email].
class EmailValidationStrategy implements FieldValidationStrategy {
  /// Creates the email strategy.
  const EmailValidationStrategy();

  @override
  FormFieldValidator<String>? resolve({
    required FormFieldValidator<String>? userValidator,
    required ValidationContext context,
  }) =>
      userValidator ?? EmailValidators.email;
}

/// Phone mode: user override or [PhoneValidators.phone].
class PhoneValidationStrategy implements FieldValidationStrategy {
  /// Creates the phone strategy.
  const PhoneValidationStrategy();

  @override
  FormFieldValidator<String>? resolve({
    required FormFieldValidator<String>? userValidator,
    required ValidationContext context,
  }) =>
      userValidator ?? PhoneValidators.phone;
}
