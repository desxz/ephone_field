import 'package:flutter/services.dart';

import '../application/phone/phone_input_session.dart';
import '../domain/phone/phone_number_service.dart';

/// Formats phone digits via [PhoneNumberService.createAsYouType].
class LibPhoneAsYouTypeFormatter extends TextInputFormatter {
  /// Creates a formatter for [regionCode] using [service].
  LibPhoneAsYouTypeFormatter({
    required PhoneNumberService service,
    required String regionCode,
  })  : _sessionManager = PhoneInputSession(service),
        _regionCode = regionCode.toUpperCase();

  final PhoneInputSession _sessionManager;
  String _regionCode;

  /// Updates the region and resets the as-you-type session.
  void updateRegion(String regionCode) {
    _regionCode = regionCode.toUpperCase();
    _sessionManager.forRegion(_regionCode).clear();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final session = _sessionManager.forRegion(_regionCode);
    session.clear();

    var formatted = '';
    for (final rune in digits.runes) {
      formatted = session.inputDigit(String.fromCharCode(rune));
    }

    if (formatted.isEmpty && digits.isNotEmpty) {
      return TextEditingValue(
        text: digits,
        selection: TextSelection.collapsed(offset: digits.length),
      );
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  /// Releases the native/session resources.
  void dispose() {
    _sessionManager.dispose();
  }
}
