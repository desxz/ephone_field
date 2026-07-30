import 'package:ephone_field/src/formatters/phone_number_digit_length_limiting_formatter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('allows up to maxDigits digits', () {
    final formatter = PhoneNumberDigitLengthLimitingFormatter(3);
    expect(
      formatter
          .formatEditUpdate(
            TextEditingValue.empty,
            const TextEditingValue(text: '123'),
          )
          .text,
      '123',
    );
  });

  test('truncates excess digits without counting separators', () {
    final formatter = PhoneNumberDigitLengthLimitingFormatter(3);
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: '12 345'),
    );
    expect(result.text.replaceAll(RegExp(r'\D'), ''), '123');
  });
}
