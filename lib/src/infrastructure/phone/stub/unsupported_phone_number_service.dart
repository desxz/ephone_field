import '../../../domain/phone/phone.dart';

/// [PhoneNumberService] used when native libphonenumber is unavailable.
///
/// All operations either return false/`null` or throw
/// [UnsupportedPhoneNumberException] for as-you-type (explicit failure).
class UnsupportedPhoneNumberService implements PhoneNumberService {
  /// Creates an unsupported service.
  const UnsupportedPhoneNumberService();

  @override
  bool get supportsAsYouTypeFormatting => false;

  static const String _message =
      'PhoneNumberService requires the native ephone_field plugin '
      '(Android/iOS). This platform has no libphonenumber binding.';

  @override
  bool isValid(String raw, {required String regionCode}) => false;

  @override
  bool isPossible(String raw, {required String regionCode}) => false;

  @override
  PhoneParseResult? parse(String raw, {required String regionCode}) => null;

  @override
  String? formatE164(String raw, {required String regionCode}) => null;

  @override
  String? formatNational(String raw, {required String regionCode}) => null;

  @override
  AsYouTypeSession createAsYouType(String regionCode) {
    throw const UnsupportedPhoneNumberException(_message);
  }
}

/// Thrown when phone formatting/validation requires native support.
class UnsupportedPhoneNumberException implements Exception {
  /// Creates an exception with [message].
  const UnsupportedPhoneNumberException(this.message);

  /// Human-readable explanation.
  final String message;

  @override
  String toString() => 'UnsupportedPhoneNumberException: $message';
}
