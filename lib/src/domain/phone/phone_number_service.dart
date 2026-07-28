import 'as_you_type_session.dart';
import 'phone_parse_result.dart';

/// Port for phone parse, validate, format, and as-you-type formatting.
///
/// UI and validators depend on this abstraction only — never on FFI or
/// libphonenumber types directly.
abstract class PhoneNumberService {
  /// Whether as-you-type formatting is backed by native libphonenumber.
  ///
  /// When `false`, callers should use legacy mask formatters instead of
  /// [createAsYouType].
  bool get supportsAsYouTypeFormatting;

  /// Whether [raw] is a valid number for [regionCode] (ISO 3166-1 alpha-2).
  bool isValid(String raw, {required String regionCode});

  /// Lenient length-based check for [raw] in [regionCode].
  bool isPossible(String raw, {required String regionCode});

  /// Parses [raw] for [regionCode], or `null` if parsing fails.
  PhoneParseResult? parse(String raw, {required String regionCode});

  /// Formats [raw] as E.164, or `null` if parsing fails.
  String? formatE164(String raw, {required String regionCode});

  /// Formats [raw] in national format for [regionCode], or `null` on failure.
  String? formatNational(String raw, {required String regionCode});

  /// Starts an as-you-type session for [regionCode].
  AsYouTypeSession createAsYouType(String regionCode);
}
