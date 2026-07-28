/// Legacy dial-code concatenation helpers.
///
/// Prefer [PhoneOutputMapper] / [PhoneNumberService.formatE164].
@Deprecated(
  'Use PhoneOutputMapper or PhoneNumberService.formatE164 instead. '
  'EphoneFieldUtils will be removed in a future release.',
)
class EphoneFieldUtils {
  /// Combines a dial code with a local phone number.
  ///
  /// Returns `null` when [phoneNumber] is null or empty.
  @Deprecated('Use PhoneOutputMapper.dialCodeFallback or formatE164.')
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
