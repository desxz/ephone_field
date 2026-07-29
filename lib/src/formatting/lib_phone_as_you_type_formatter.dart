import 'package:flutter/services.dart';

import '../application/phone/phone_input_session.dart';
import '../domain/phone/as_you_type_session.dart';
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
  String _trackedDigits = '';

  /// Updates the region and resets the as-you-type session.
  void updateRegion(String regionCode) {
    _regionCode = regionCode.toUpperCase();
    _trackedDigits = '';
    _sessionManager.forRegion(_regionCode).clear();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final oldDigits = oldValue.text.replaceAll(RegExp(r'\D'), '');
    final newDigits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (newDigits == _trackedDigits && newValue.text == oldValue.text) {
      return newValue;
    }

    final session = _sessionManager.forRegion(_regionCode);
    final formatted = _formatDigits(
      session: session,
      oldDigits: oldDigits,
      newDigits: newDigits,
    );
    _trackedDigits = newDigits;

    if (formatted.isEmpty && newDigits.isNotEmpty) {
      return _collapseToEnd(newDigits);
    }

    return _collapseToEnd(formatted);
  }

  String _formatDigits({
    required AsYouTypeSession session,
    required String oldDigits,
    required String newDigits,
  }) {
    if (newDigits.isEmpty) {
      session.clear();
      return '';
    }

    final canAppend = newDigits.length > oldDigits.length &&
        newDigits.startsWith(oldDigits) &&
        _trackedDigits == oldDigits;
    if (canAppend) {
      final added = newDigits.substring(oldDigits.length);
      var formatted = '';
      for (final rune in added.runes) {
        formatted = session.inputDigit(String.fromCharCode(rune));
      }
      return formatted;
    }

    final canBackspace = newDigits.length < oldDigits.length &&
        oldDigits.startsWith(newDigits) &&
        _trackedDigits == oldDigits;
    if (canBackspace) {
      return _rebuildSession(session, newDigits);
    }

    return _rebuildSession(session, newDigits);
  }

  String _rebuildSession(AsYouTypeSession session, String digits) {
    session.clear();
    var formatted = '';
    for (final rune in digits.runes) {
      formatted = session.inputDigit(String.fromCharCode(rune));
    }
    return formatted;
  }

  TextEditingValue _collapseToEnd(String text) {
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  /// Releases the native/session resources.
  void dispose() {
    _sessionManager.dispose();
    _trackedDigits = '';
  }
}
