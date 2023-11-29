import 'package:flutter/services.dart';

import '../enums/enums.dart';

class PhoneNumberMaskFormatter extends TextInputFormatter {
  final Country country;
  final String? maskSplitCharacter;

  const PhoneNumberMaskFormatter({required this.country, required this.maskSplitCharacter});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final String mask = country.mask;
    final String maskCharacter = country.mask[0];
    String text = newValue.text;
    String oldText = oldValue.text;
    if (maskSplitCharacter != null) {
      text = text.replaceAll(maskSplitCharacter!, '');
      oldText = oldText.replaceAll(maskSplitCharacter!, '');
    }
    final String newText = _applyMask(mask, maskCharacter, maskSplitCharacter, text, oldText);
    final int selectionIndex = newText.length;

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  String _applyMask(
    String mask,
    String maskCharacter,
    String? maskSplitCharacter,
    String text,
    String oldText,
  ) {
    if (maskSplitCharacter == null) return text;
    final StringBuffer newText = StringBuffer();

    int textIndex = 0;

    for (int i = 0; i < mask.length; i++) {
      if (textIndex >= text.length) {
        break;
      }

      if (mask[i] == maskCharacter) {
        newText.write(text[textIndex]);
        textIndex++;
      } else {
        newText.write(maskSplitCharacter);
      }
    }

    if (oldText.length > text.length && newText.toString().endsWith(maskSplitCharacter)) {
      newText.write(oldText[oldText.length - 1]);
    }

    return newText.toString();
  }
}
