import 'package:flutter/services.dart';

/// Limits input to at most [maxDigits] digit characters (ignores separators).
class PhoneNumberDigitLengthLimitingFormatter extends TextInputFormatter {
  /// Creates a formatter that keeps at most [maxDigits] digits.
  PhoneNumberDigitLengthLimitingFormatter(this.maxDigits)
    : assert(maxDigits >= 0);

  /// Maximum number of digits allowed.
  final int maxDigits;

  static final RegExp _nonDigit = RegExp(r'\D');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitCount = newValue.text.replaceAll(_nonDigit, '').length;
    if (digitCount <= maxDigits) {
      return newValue;
    }

    final buffer = StringBuffer();
    var keptDigits = 0;
    for (final rune in newValue.text.runes) {
      final isDigit = rune >= 0x30 && rune <= 0x39;
      if (isDigit) {
        if (keptDigits >= maxDigits) {
          continue;
        }
        keptDigits++;
      }
      buffer.writeCharCode(rune);
    }

    final truncated = buffer.toString();
    final base =
        newValue.selection.isValid
            ? newValue.selection.baseOffset.clamp(0, newValue.text.length)
            : newValue.text.length;
    var digitsBefore =
        newValue.text.substring(0, base).replaceAll(_nonDigit, '').length;
    if (digitsBefore > maxDigits) {
      digitsBefore = maxDigits;
    }

    return TextEditingValue(
      text: truncated,
      selection: TextSelection.collapsed(
        offset: _offsetForDigitCount(truncated, digitsBefore),
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
}
