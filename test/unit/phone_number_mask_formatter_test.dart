import 'package:ephone_field/ephone_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formats number with whitespace', () {
    expect(
      PhoneNumberMaskFormatter(
        country: Country.unitedStates,
        maskSplitCharacter: ' ',
      )
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: '1234567890'),
          )
          .text,
      '123 456 7890',
    );
  });

  test('formats number with dash', () {
    expect(
      PhoneNumberMaskFormatter(
        country: Country.unitedStates,
        maskSplitCharacter: '-',
      )
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: '1234567890'),
          )
          .text,
      '123-456-7890',
    );
  });

  test('truncates extra digits', () {
    expect(
      PhoneNumberMaskFormatter(
        country: Country.unitedStates,
        maskSplitCharacter: ' ',
      )
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: '1234567890123456'),
          )
          .text,
      '123 456 7890',
    );
  });

  test('formats partial numbers', () {
    expect(
      PhoneNumberMaskFormatter(
        country: Country.unitedStates,
        maskSplitCharacter: ' ',
      )
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: '12345'),
          )
          .text,
      '123 45',
    );
  });

  test('returns empty for empty input', () {
    expect(
      PhoneNumberMaskFormatter(
        country: Country.unitedStates,
        maskSplitCharacter: ' ',
      )
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: ''),
          )
          .text,
      '',
    );
  });

  test('strips non-numeric characters before masking', () {
    expect(
      PhoneNumberMaskFormatter(
        country: Country.unitedStates,
        maskSplitCharacter: ' ',
      )
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: '123asd4567890'),
          )
          .text,
      '123 456 7890',
    );
  });
}
