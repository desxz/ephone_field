class EphoneFieldUtils {
  static String? combinePrefix(
      int prefix, String? phoneNumber, String maskSplitter) {
    if (phoneNumber == null || phoneNumber.isEmpty) return null;
    return '+${prefix.toString() + phoneNumber.replaceAll(maskSplitter, '')}';
  }
}
