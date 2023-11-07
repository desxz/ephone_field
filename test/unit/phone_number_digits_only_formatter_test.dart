import 'package:ephone_field/src/formatters/formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'should PhoneNumberDigitsOnlyFormatter formats all numeric string',
    () {
      expect(
          const PhoneNumberDigistOnlyFormatter(maskSplitCharacter: '')
              .formatEditUpdate(
                TextEditingValue.empty,
                const TextEditingValue(text: "1234567890"),
              )
              .text,
          "1234567890");
    },
  );

  test(
    'should PhoneNumberDigitsOnlyFormatter formats all numeric string and remove others',
    () {
      expect(
          const PhoneNumberDigistOnlyFormatter(maskSplitCharacter: '')
              .formatEditUpdate(
                TextEditingValue.empty,
                const TextEditingValue(text: "1234567890abc"),
              )
              .text,
          "1234567890");
    },
  );

  test(
    'should PhoneNumberDigitsOnlyFormatter formats with empty value',
    () {
      expect(
          const PhoneNumberDigistOnlyFormatter(maskSplitCharacter: '')
              .formatEditUpdate(
                TextEditingValue.empty,
                const TextEditingValue(text: ""),
              )
              .text,
          "");
    },
  );

  test(
    'should PhoneNumberDigitsOnlyFormatter formats numeric values with mask split character',
    () {
      expect(
          const PhoneNumberDigistOnlyFormatter(maskSplitCharacter: '-')
              .formatEditUpdate(
                TextEditingValue.empty,
                const TextEditingValue(text: "123456-7890asd"),
              )
              .text,
          "123456-7890");
    },
  );

  test(
    'should PhoneNumberDigitsOnlyFormatter formats numeric values with missing mask split character',
    () {
      expect(
          const PhoneNumberDigistOnlyFormatter(maskSplitCharacter: ' ')
              .formatEditUpdate(
                TextEditingValue.empty,
                const TextEditingValue(text: "123456-7890asd"),
              )
              .text,
          "1234567890");
    },
  );
}
