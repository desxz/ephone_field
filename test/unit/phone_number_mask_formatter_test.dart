import 'package:ephone_field/ephone_field.dart';
import 'package:ephone_field/src/formatters/formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should PhoneNumberMaskFormatter formats number with whitespace', () {
    expect(
        const PhoneNumberMaskFormatter(
                country: Country.unitedStates, maskSplitCharacter: ' ')
            .formatEditUpdate(
              TextEditingValue.empty,
              const TextEditingValue(text: "1234567890"),
            )
            .text,
        "123 4567 890");
  });

  test('should PhoneNumberMaskFormatter formats number with dash', () {
    expect(
        const PhoneNumberMaskFormatter(
                country: Country.unitedStates, maskSplitCharacter: '-')
            .formatEditUpdate(
              TextEditingValue.empty,
              const TextEditingValue(text: "1234567890"),
            )
            .text,
        "123-4567-890");
  });

  test('should PhoneNumberMaskFormatter formats number and remove others', () {
    expect(
        const PhoneNumberMaskFormatter(
                country: Country.unitedStates, maskSplitCharacter: ' ')
            .formatEditUpdate(
              TextEditingValue.empty,
              const TextEditingValue(text: "1234567890123456"),
            )
            .text,
        "123 4567 890");
  });

  test('should PhoneNumberMaskFormatter formats with missing values', () {
    expect(
        const PhoneNumberMaskFormatter(
                country: Country.unitedStates, maskSplitCharacter: ' ')
            .formatEditUpdate(
              TextEditingValue.empty,
              const TextEditingValue(text: "12345"),
            )
            .text,
        "123 45");
  });

  test('should PhoneNumberMaskFormatter formats with empty value', () {
    expect(
        const PhoneNumberMaskFormatter(
                country: Country.unitedStates, maskSplitCharacter: ' ')
            .formatEditUpdate(
              TextEditingValue.empty,
              const TextEditingValue(text: ""),
            )
            .text,
        "");
  });

  test('should PhoneNumberMaskFormatter formats with nonnumeric value', () {
    expect(
        const PhoneNumberMaskFormatter(
                country: Country.unitedStates, maskSplitCharacter: ' ')
            .formatEditUpdate(
              TextEditingValue.empty,
              const TextEditingValue(text: "123asd123"),
            )
            .text,
        "123 asd1 23");
  });
}
