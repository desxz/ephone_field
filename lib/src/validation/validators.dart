import 'package:flutter/widgets.dart';

import '../enums/ephone_textfield_type.dart';
import 'email_validators.dart';
import 'phone_validators.dart';
import 'validation_context.dart';

/// Chain-of-responsibility helpers for [FormFieldValidator]s.
abstract final class Validators {
  /// Runs [validators] in order; returns the first non-null error.
  static FormFieldValidator<String> compose(
    List<FormFieldValidator<String>> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }

  /// Runs [base] then [extra] (fail-fast).
  static FormFieldValidator<String> andThen(
    FormFieldValidator<String> base,
    FormFieldValidator<String> extra,
  ) => compose(<FormFieldValidator<String>>[base, extra]);
}

/// Resolves the effective [FormFieldValidator] for an [EphoneFieldType].
///
/// Phone defaults use [PhoneValidators.phoneWith] with [context] so package
/// defaults do not require [ValidationBinding]. User-supplied
/// [PhoneValidators.phone] still needs binding when composed.
FormFieldValidator<String>? resolveFieldValidator(
  EphoneFieldType type, {
  required FormFieldValidator<String>? userValidator,
  required ValidationContext context,
}) {
  switch (type) {
    case EphoneFieldType.initial:
      final message = context.emptyErrorText;
      if (message == null) {
        return null;
      }
      return (value) => value == null || value.isEmpty ? message : null;
    case EphoneFieldType.email:
      return userValidator ?? EmailValidators.email;
    case EphoneFieldType.phone:
      return userValidator ??
          (value) => PhoneValidators.phoneWith(value, context);
  }
}
