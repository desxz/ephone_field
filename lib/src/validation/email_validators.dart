/// Predicate helpers for HTML5/WHATWG-oriented email syntax checks.
abstract final class EmailSyntax {
  /// RFC 5321 practical address length cap.
  static const int maxAddressLength = 254;

  /// RFC 5321 local-part length cap.
  static const int maxLocalLength = 64;

  /// WHATWG HTML5 email input pattern (willful RFC 5322 simplification).
  ///
  /// Allows plus-addressing and common atext; rejects quoted locals and
  /// IP-literal domains. Requires at least one `.` in the domain (TLD).
  static final RegExp html5WithTld = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
    r'[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?'
    r'(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$',
  );

  /// Whether [value] is null or empty after trim.
  static bool isBlank(String? value) => value == null || value.trim().isEmpty;

  /// Whether [value] exceeds the address length cap.
  static bool exceedsAddressLength(String value) =>
      value.length > maxAddressLength;

  /// Whether the local part exceeds [maxLocalLength].
  static bool exceedsLocalLength(String value) {
    final at = value.indexOf('@');
    if (at < 0) {
      return false;
    }
    return at > maxLocalLength;
  }

  /// Whether [value] matches the HTML5-with-TLD form pattern.
  static bool matchesHtml5(String value) => html5WithTld.hasMatch(value);

  /// Whether [value] is a syntactically acceptable form email.
  static bool isValid(String value) {
    final trimmed = value.trim();
    return !exceedsAddressLength(trimmed) &&
        !exceedsLocalLength(trimmed) &&
        matchesHtml5(trimmed);
  }
}

/// Package email [FormField] validators (also used as EPhoneField defaults).
abstract final class EmailValidators {
  /// Validates email syntax (HTML5/WHATWG + length). Returns `null` when valid.
  static String? email(
    String? value, {
    String emptyMessage = 'Email is required',
    String invalidMessage = 'Enter a valid email address',
  }) {
    if (EmailSyntax.isBlank(value)) {
      return emptyMessage;
    }
    if (!EmailSyntax.isValid(value!.trim())) {
      return invalidMessage;
    }
    return null;
  }
}
