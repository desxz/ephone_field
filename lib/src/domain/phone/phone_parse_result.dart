/// Result of parsing a phone number into a canonical form.
class PhoneParseResult {
  /// Creates a parse result.
  const PhoneParseResult({
    required this.e164,
    required this.nationalNumber,
    required this.countryCode,
    required this.regionCode,
  });

  /// E.164 representation (for example `+14155552671`).
  final String e164;

  /// National significant number digits only.
  final String nationalNumber;

  /// ITU country calling code (for example `1` for US).
  final int countryCode;

  /// ISO 3166-1 alpha-2 region used for parsing context.
  final String regionCode;
}
