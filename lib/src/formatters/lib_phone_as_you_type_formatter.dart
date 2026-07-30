import 'package:flutter/services.dart';

import '../domain/phone/as_you_type_session.dart';
import '../domain/phone/phone_number_service.dart';

/// Formats phone digits via [PhoneNumberService.createAsYouType].
class LibPhoneAsYouTypeFormatter extends TextInputFormatter {
  /// Creates a formatter for [regionCode] using [service].
  LibPhoneAsYouTypeFormatter({
    required PhoneNumberService service,
    required String regionCode,
  })  : _service = service,
        _regionCode = regionCode.toUpperCase();

  final PhoneNumberService _service;
  String _regionCode;
  AsYouTypeSession? _session;
  String _trackedDigits = '';

  static final RegExp _nonDigit = RegExp(r'\D');

  AsYouTypeSession _sessionForRegion() {
    if (_session != null) {
      return _session!;
    }
    _session = _service.createAsYouType(_regionCode);
    return _session!;
  }

  /// Updates the region and resets the as-you-type session.
  void updateRegion(String regionCode) {
    final normalized = regionCode.toUpperCase();
    if (normalized == _regionCode) {
      _trackedDigits = '';
      _session?.clear();
      return;
    }
    _session?.dispose();
    _session = null;
    _regionCode = normalized;
    _trackedDigits = '';
  }

  /// Formats [digits] for the current region (full rebuild).
  String formatDigits(String digits) {
    final national = digits.replaceAll(_nonDigit, '');
    if (national.isEmpty) {
      _sessionForRegion().clear();
      _trackedDigits = '';
      return '';
    }
    final formatted = _rebuildSession(_sessionForRegion(), national);
    _trackedDigits = national;
    return formatted;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final oldDigits = oldValue.text.replaceAll(_nonDigit, '');
    final newDigits = newValue.text.replaceAll(_nonDigit, '');

    if (newDigits == _trackedDigits && newValue.text == oldValue.text) {
      return newValue;
    }

    final session = _sessionForRegion();
    final formatted = _formatDigits(
      session: session,
      oldDigits: oldDigits,
      newDigits: newDigits,
    );
    _trackedDigits = newDigits;

    if (formatted.isEmpty && newDigits.isNotEmpty) {
      return _selectionForDigits(
        text: newDigits,
        newValue: newValue,
      );
    }

    return _selectionForDigits(
      text: formatted,
      newValue: newValue,
    );
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

  /// Maps the caret from [newValue] onto [text] by counting digits before the
  /// caret, so mid-string edits do not jump to the end.
  TextEditingValue _selectionForDigits({
    required String text,
    required TextEditingValue newValue,
  }) {
    final caretInNew = newValue.selection.isValid
        ? newValue.selection.baseOffset.clamp(0, newValue.text.length)
        : newValue.text.length;
    final digitsBeforeCaret =
        newValue.text.substring(0, caretInNew).replaceAll(_nonDigit, '').length;

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: _offsetForDigitCount(text, digitsBeforeCaret),
      ),
    );
  }

  static int _offsetForDigitCount(String text, int digitCount) {
    if (digitCount <= 0) {
      return 0;
    }
    var seen = 0;
    for (var i = 0; i < text.length; i++) {
      final code = text.codeUnitAt(i);
      if (code >= 0x30 && code <= 0x39) {
        seen++;
        if (seen == digitCount) {
          return i + 1;
        }
      }
    }
    return text.length;
  }

  /// Releases the native/session resources.
  void dispose() {
    _session?.dispose();
    _session = null;
    _trackedDigits = '';
  }
}
