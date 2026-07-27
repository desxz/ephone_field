import 'package:ephone_field/ephone_field.dart';
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
}
