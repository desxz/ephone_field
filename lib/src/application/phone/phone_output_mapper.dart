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
  static String? dialCodeFallback({
    required String raw,
    required int dialCode,
  }) {
    final digitsOnly = raw.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.isEmpty) {
      return null;
    }
    return '+$dialCode$digitsOnly';
  }
}
