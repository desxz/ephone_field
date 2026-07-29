import '../domain/phone/phone_number_service.dart';
import '../enums/country.dart';

/// Decides whether a phone string is acceptable for a region/country.
abstract class PhoneValidityCheck {
  /// Whether [raw] is considered valid.
  bool isValid(String raw);

  /// Picks libphonenumber check or country length fallback.
  static PhoneValidityCheck forService({
    required PhoneNumberService service,
    required Country country,
  }) {
    if (!service.supportsNativeValidation) {
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
