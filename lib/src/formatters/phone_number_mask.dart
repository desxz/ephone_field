import 'package:flutter/services.dart';

import '../enums/country.dart';

/// Placeholder character in country phone masks.
const String kPhoneMaskPlaceholder = '#';

/// Formats phone numbers according to a country mask.
class PhoneNumberMaskFormatter extends TextInputFormatter {
  /// Creates a mask formatter for [country] using [maskSplitCharacter].
  PhoneNumberMaskFormatter({
    required this.country,
    required this.maskSplitCharacter,
  });

  /// Country whose mask is applied.
  final Country country;

  /// Character inserted between mask groups (for example a space).
  final String maskSplitCharacter;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final mask = country.mask;
    if (mask.isEmpty) {
      return newValue;
    }

    final oldDigits = _digitsOnly(oldValue.text);
    final newDigits = _digitsOnly(newValue.text);
    final maxDigits =
        mask.split('').where((c) => c == kPhoneMaskPlaceholder).length;
    final limitedDigits = newDigits.length > maxDigits
        ? newDigits.substring(0, maxDigits)
        : newDigits;

    final masked = _applyMask(mask, limitedDigits);
    final isDeleting = newDigits.length < oldDigits.length;
    final selection = _computeSelection(
      oldValue: oldValue,
      newMasked: masked,
      oldDigits: oldDigits,
      newDigits: limitedDigits,
      isDeleting: isDeleting,
    );

    return TextEditingValue(text: masked, selection: selection);
  }

  String _digitsOnly(String text) {
    return text.replaceAll(RegExp('[^0-9]'), '');
  }

  String _applyMask(String mask, String digits) {
    final buffer = StringBuffer();
    var digitIndex = 0;

    for (var i = 0; i < mask.length; i++) {
      if (digitIndex >= digits.length) {
        break;
      }
      if (mask[i] == kPhoneMaskPlaceholder) {
        buffer.write(digits[digitIndex]);
        digitIndex++;
      } else {
        buffer.write(maskSplitCharacter);
      }
    }

    return buffer.toString();
  }

  TextSelection _computeSelection({
    required TextEditingValue oldValue,
    required String newMasked,
    required String oldDigits,
    required String newDigits,
    required bool isDeleting,
  }) {
    final oldOffset =
        oldValue.selection.baseOffset.clamp(0, oldValue.text.length);
    final digitsBeforeCursor =
        _digitsOnly(oldValue.text.substring(0, oldOffset)).length;

    if (isDeleting &&
        newMasked.isNotEmpty &&
        newMasked.endsWith(maskSplitCharacter)) {
      return TextSelection.collapsed(
          offset: newMasked.length - maskSplitCharacter.length);
    }

    var digitCount = 0;
    var targetOffset = newMasked.length;

    for (var i = 0; i < newMasked.length; i++) {
      if (RegExp(r'[0-9]').hasMatch(newMasked[i])) {
        digitCount++;
        if (digitCount >= digitsBeforeCursor) {
          targetOffset = i + 1;
          break;
        }
      }
    }

    if (digitsBeforeCursor == 0) {
      targetOffset = 0;
    } else if (digitsBeforeCursor >= newDigits.length) {
      targetOffset = newMasked.length;
    }

    return TextSelection.collapsed(
        offset: targetOffset.clamp(0, newMasked.length));
  }
}
