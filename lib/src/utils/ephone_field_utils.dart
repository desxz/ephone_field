class EphoneFieldUtils {
  static String? combinePrefix(int prefix, String? phoneNumber, String? maskSplitter) {
    if (phoneNumber == null || phoneNumber.isEmpty) return null;
    final String phoneNumberWithPrefix = '+${prefix.toString() + phoneNumber}';
    return maskSplitter == null ? phoneNumberWithPrefix : phoneNumberWithPrefix.replaceAll(maskSplitter, '');
  }
}
