import '../domain/phone/phone_number_service.dart';
import '../enums/country.dart';
import '../infrastructure/phone/stub/unsupported_phone_number_service.dart';
import 'field_validation_strategy.dart';
import 'validation_binding.dart';

/// Decides whether a phone string is acceptable for a region/country.
abstract class PhoneValidityCheck {
  /// Whether [raw] is considered valid.
  bool isValid(String raw);

  /// Picks libphonenumber check or country length fallback.
  static PhoneValidityCheck forService({
    required PhoneNumberService service,
    required Country country,
  }) {
    if (service is UnsupportedPhoneNumberService) {
      return CountryLengthValidityCheck(country);
    }
    return LibPhoneValidityCheck(service, country.alpha2);
  }
}

/// Uses [PhoneNumberService.isValid].
class LibPhoneValidityCheck implements PhoneValidityCheck {
  /// Creates a libphonenumber-backed check.
  const LibPhoneValidityCheck(this.service, this.regionCode);

  /// Phone capability.
  final PhoneNumberService service;

  /// ISO region code.
  final String regionCode;

  @override
  bool isValid(String raw) => service.isValid(raw, regionCode: regionCode);
}

/// Legacy min/max national length check when native phone is unavailable.
class CountryLengthValidityCheck implements PhoneValidityCheck {
  /// Creates a length-based check for [country].
  const CountryLengthValidityCheck(this.country);

  /// Country providing dial code and length bounds.
  final Country country;

  @override
  bool isValid(String raw) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    final dial = country.dialCode.toString();
    final nationalLength =
        digits.startsWith(dial) ? digits.length - dial.length : digits.length;
    return nationalLength >= country.minLength &&
        nationalLength <= country.maxLength;
  }
}

/// Package phone [FormField] validators (also used as EPhoneField defaults).
abstract final class PhoneValidators {
  /// Package default phone validator — same call shape as [EmailValidators.email].
  ///
  /// Reads country and phone capability from [ValidationBinding] (set by
  /// [EPhoneField] while validating).
  static String? phone(
    String? value, {
    String emptyMessage = 'Phone number is required',
    String invalidMessage = 'Enter a valid phone number',
  }) {
    return phoneWith(
      value,
      ValidationBinding.requireCurrent(),
      emptyMessage: emptyMessage,
      invalidMessage: invalidMessage,
    );
  }

  /// Same rules as [phone], with an explicit [context] (tests / advanced).
  static String? phoneWith(
    String? value,
    ValidationContext context, {
    String emptyMessage = 'Phone number is required',
    String invalidMessage = 'Enter a valid phone number',
    PhoneValidityCheck? validityCheck,
  }) {
    if (value == null || value.isEmpty) {
      return emptyMessage;
    }
    final check = validityCheck ??
        PhoneValidityCheck.forService(
          service: context.phoneService,
          country: context.country,
        );
    if (!check.isValid(value)) {
      return invalidMessage;
    }
    return null;
  }
}
