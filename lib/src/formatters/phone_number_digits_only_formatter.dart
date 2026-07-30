import 'package:flutter/services.dart';

/// Allows only digits and an optional separator character in phone input.
class PhoneNumberDigitsOnlyFormatter extends TextInputFormatter {
  /// Creates a digits-only formatter.
  ///
  /// When [maskSplitCharacter] is provided, that character is also permitted
  /// (for example a space from AsYouType output).
  PhoneNumberDigitsOnlyFormatter({this.maskSplitCharacter});

  /// Optional separator character to preserve while filtering.
  final String? maskSplitCharacter;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final disallowed =
        maskSplitCharacter == null
            ? RegExp(r'[^0-9]')
            : RegExp('[^0-9${RegExp.escape(maskSplitCharacter!)}]');
    final filtered = newValue.text.replaceAll(disallowed, '');

    // Preserve selection from a previous formatter (e.g. AsYouType) when
    // nothing was stripped — recalculating from [oldValue] freezes the caret.
    if (filtered == newValue.text) {
      return newValue;
    }

    return TextEditingValue(
      text: filtered,
      selection: _selectionAfterFilter(
        original: newValue,
        filtered: filtered,
        disallowed: disallowed,
      ),
    );
  }

  TextSelection _selectionAfterFilter({
    required TextEditingValue original,
    required String filtered,
    required RegExp disallowed,
  }) {
    final base =
        original.selection.isValid
            ? original.selection.baseOffset.clamp(0, original.text.length)
            : original.text.length;

    final keptBefore =
        original.text.substring(0, base).replaceAll(disallowed, '').length;

    return TextSelection.collapsed(
      offset: keptBefore.clamp(0, filtered.length),
    );
  }
}
