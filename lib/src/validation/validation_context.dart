import '../domain/phone/phone_number_service.dart';
import '../enums/country.dart';

/// Shared inputs for field validation inside [EPhoneField].
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
