import 'package:flutter/widgets.dart';

import '../domain/phone/phone_number_service.dart';
import '../enums/country.dart';

/// Shared inputs for field validation strategies.
class ValidationContext {
  /// Creates a validation context.
  const ValidationContext({
    required this.phoneService,
    required this.country,
    this.emptyErrorText,
  });

  /// Phone capability used by the phone default validator.
  final PhoneNumberService phoneService;

  /// Currently selected country (region + length fallback).
  final Country country;

  /// Optional message when the field is empty in initial mode.
  final String? emptyErrorText;
}

/// Resolves the [FormFieldValidator] for a field mode.
abstract class FieldValidationStrategy {
  /// Returns the effective validator: user override or package default.
  FormFieldValidator<String>? resolve({
    required FormFieldValidator<String>? userValidator,
    required ValidationContext context,
  });
}
