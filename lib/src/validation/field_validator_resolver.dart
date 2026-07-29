import 'package:flutter/widgets.dart';

import '../enums/ephone_textfield_type.dart';
import 'email_validators.dart';
import 'phone_validators.dart';
import 'validation_context.dart';

/// Resolves the effective [FormFieldValidator] for an [EphoneFieldType].
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
      return userValidator ?? PhoneValidators.phone;
  }
}
