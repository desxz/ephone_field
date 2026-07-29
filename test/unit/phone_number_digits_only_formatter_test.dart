import 'package:ephone_field/ephone_field.dart';
import 'package:ephone_field/src/formatters/phone_number_digits_only_formatter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('keeps all numeric characters', () {
    expect(
      PhoneNumberDigitsOnlyFormatter(maskSplitCharacter: null)
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: '1234567890'),
          )
          .text,
      '1234567890',
    );
  });

  test('removes non-numeric characters', () {
    expect(
      PhoneNumberDigitsOnlyFormatter(maskSplitCharacter: null)
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: '1234567890abc'),
          )
          .text,
      '1234567890',
    );
  });

  test('does not allow letters when splitter is null', () {
    expect(
      PhoneNumberDigitsOnlyFormatter(maskSplitCharacter: null)
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: 'null'),
          )
          .text,
      '',
    );
  });

  test('returns empty for empty input', () {
    expect(
      PhoneNumberDigitsOnlyFormatter(maskSplitCharacter: null)
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: ''),
          )
          .text,
      '',
    );
  });

  test('keeps mask split character', () {
    expect(
      PhoneNumberDigitsOnlyFormatter(maskSplitCharacter: '-')
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: '123456-7890asd'),
          )
          .text,
      '123456-7890',
    );
  });

  test('removes unsupported separators', () {
    expect(
      PhoneNumberDigitsOnlyFormatter(maskSplitCharacter: ' ')
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: '123456-7890asd'),
          )
          .text,
      '1234567890',
    );
  });

  test('preserves selection when nothing is stripped', () {
    final result = PhoneNumberDigitsOnlyFormatter(maskSplitCharacter: ' ')
        .formatEditUpdate(
      const TextEditingValue(
        text: '4',
        selection: TextSelection.collapsed(offset: 1),
      ),
      const TextEditingValue(
        text: '41',
        selection: TextSelection.collapsed(offset: 2),
      ),
    );

    expect(result.text, '41');
    expect(result.selection.baseOffset, 2);
  });

  test('maps selection when characters are stripped', () {
    final result = PhoneNumberDigitsOnlyFormatter(maskSplitCharacter: ' ')
        .formatEditUpdate(
      const TextEditingValue(
        text: '41',
        selection: TextSelection.collapsed(offset: 2),
      ),
      const TextEditingValue(
        text: '41a5',
        selection: TextSelection.collapsed(offset: 4),
      ),
    );

    expect(result.text, '415');
    expect(result.selection.baseOffset, 3);
  });
}
