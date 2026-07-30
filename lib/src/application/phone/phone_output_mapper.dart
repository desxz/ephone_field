import '../../domain/phone/phone.dart';

/// Maps field input to callback-friendly phone strings via [PhoneNumberService].
class PhoneOutputMapper {
  /// Creates a mapper bound to [service].
  const PhoneOutputMapper(this.service);

  /// Phone capability used for E.164 formatting.
  final PhoneNumberService service;

  /// Returns E.164 when [service] can parse [raw] for [regionCode].
  ///
  /// Falls back to a dial-code concatenation when parse fails, preserving
  /// previous callback behavior for incomplete input.
  String? mapForCallback({
    required String? raw,
    required String regionCode,
    required int dialCode,
  }) {
    if (raw == null || raw.isEmpty) {
      return null;
    }

    final e164 = service.formatE164(raw, regionCode: regionCode);
    if (e164 != null) {
      return e164;
    }

    return dialCodeFallback(raw: raw, dialCode: dialCode);
  }

  /// Legacy-style `+{dialCode}{digits}` used when E.164 formatting is unavailable.
  ///
  /// When [raw] already looks international (`+…` or `00…`), a leading dial-code
  /// prefix matching [dialCode] is stripped first so pasted E.164-like values
  /// are not doubled (e.g. `+1 415…` with US → `+1415…`, not `+11415…`).
  static String? dialCodeFallback({
    required String raw,
    required int dialCode,
  }) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return null;
    }

    var digitsOnly = trimmed.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.isEmpty) {
      return null;
    }

    final dialDigits = dialCode.toString();
    final looksInternational =
        trimmed.startsWith('+') || trimmed.startsWith('00');
    if (looksInternational) {
      // Strip trunk "00" international prefix from the digit stream first.
      if (digitsOnly.startsWith('00')) {
        digitsOnly = digitsOnly.substring(2);
      }
      if (digitsOnly.startsWith(dialDigits) &&
          digitsOnly.length > dialDigits.length) {
        digitsOnly = digitsOnly.substring(dialDigits.length);
      }
    }

    if (digitsOnly.isEmpty) {
      return null;
    }
    return '+$dialCode$digitsOnly';
  }
}
