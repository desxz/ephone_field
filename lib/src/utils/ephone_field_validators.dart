import 'package:ephone_field/ephone_field.dart';

import '../infrastructure/phone/stub/unsupported_phone_number_service.dart';

/// Deprecated facade over [EmailValidators] / [PhoneValidators].
@Deprecated(
  'Use EmailValidators and PhoneValidators from the validation module. '
  'EphoneFieldValidators will be removed in a future release.',
)
abstract final class EphoneFieldValidators {
  /// Validates a basic email shape.
  @Deprecated('Use EmailValidators.email.')
  static String? email(String? value) => EmailValidators.email(value);

  /// Length-based phone validator (legacy). Prefer [PhoneValidators.phone].
  @Deprecated(
      'Use PhoneValidators.phone inside EPhoneField / ValidationBinding.')
  static String? Function(String?) phone(Country country) {
    return (String? value) => PhoneValidators.phoneWith(
          value,
          ValidationContext(
            phoneService: const UnsupportedPhoneNumberService(),
            country: country,
          ),
        );
  }
}
