import 'package:flutter/services.dart';

/// Allows only digits and an optional mask separator in phone input.
class PhoneNumberDigitsOnlyFormatter extends TextInputFormatter {
  /// Creates a digits-only formatter.
  ///
  /// When [maskSplitCharacter] is provided, that character is also permitted.
  PhoneNumberDigitsOnlyFormatter({this.maskSplitCharacter});

  /// Optional mask separator character to preserve while filtering.
  final String? maskSplitCharacter;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final allowed = maskSplitCharacter == null
        ? RegExp(r'[^0-9]')
        : RegExp('[^0-9${RegExp.escape(maskSplitCharacter!)}]');
    final newText = newValue.text.replaceAll(allowed, '');
    final selection = _preserveSelection(
      oldValue: oldValue,
      newText: newText,
    );

    return TextEditingValue(text: newText, selection: selection);
  }

  TextSelection _preserveSelection({
    required TextEditingValue oldValue,
    required String newText,
  }) {
    final oldOffset =
        oldValue.selection.baseOffset.clamp(0, oldValue.text.length);
    final removedBefore = oldValue.text.substring(0, oldOffset).length -
        oldValue.text
            .substring(0, oldOffset)
            .replaceAll(
              maskSplitCharacter == null
                  ? RegExp(r'[^0-9]')
                  : RegExp('[^0-9${RegExp.escape(maskSplitCharacter!)}]'),
              '',
            )
            .length;

    var offset = oldOffset - removedBefore;
    if (offset > newText.length) {
      offset = newText.length;
    }
    if (offset < 0) {
      offset = 0;
    }

    return TextSelection.collapsed(offset: offset);
  }
}

/// Deprecated alias for [PhoneNumberDigitsOnlyFormatter].
@Deprecated('Use PhoneNumberDigitsOnlyFormatter instead.')
typedef PhoneNumberDigistOnlyFormatter = PhoneNumberDigitsOnlyFormatter;
