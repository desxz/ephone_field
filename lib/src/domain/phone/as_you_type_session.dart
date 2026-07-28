/// Incremental phone formatting session for a single region.
///
/// Create via [PhoneNumberService.createAsYouType]. Call [dispose] when the
/// region changes or the field is disposed.
abstract class AsYouTypeSession {
  /// Appends a single digit (or formatting-significant character) and returns
  /// the partially formatted national number so far.
  String inputDigit(String digit);

  /// Clears accrued input so a new number can be entered.
  void clear();

  /// Releases native or other resources held by this session.
  void dispose();
}
