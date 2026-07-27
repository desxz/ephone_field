/// Utility helpers for [EPhoneField].
class EphoneFieldUtils {
  /// Combines a dial code with a local phone number.
  ///
  /// Returns `null` when [phoneNumber] is null or empty.
  static String? combinePrefix(
    int prefix,
    String? phoneNumber,
    String? maskSplitter,
  ) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return null;
    }
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.isEmpty) {
      return null;
    }
    final phoneNumberWithPrefix = '+$prefix$digitsOnly';
    return maskSplitter == null
        ? phoneNumberWithPrefix
        : phoneNumberWithPrefix.replaceAll(maskSplitter, '');
  }
}
