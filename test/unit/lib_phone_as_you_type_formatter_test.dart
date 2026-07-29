import 'package:ephone_field/src/domain/phone/phone.dart';
import 'package:ephone_field/src/formatting/lib_phone_as_you_type_formatter.dart';
import 'package:ephone_field/src/formatters/phone_number_digits_only_formatter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fake_phone_number_service.dart';

class _EmptyOutputAsYouTypeSession implements AsYouTypeSession {
  @override
  String inputDigit(String digit) => '';

  @override
  void clear() {}

  @override
  void dispose() {}
}

class _EmptyOutputPhoneNumberService extends FakePhoneNumberService {
  _EmptyOutputPhoneNumberService()
      : super(supportsAsYouTypeFormatting: true);

  @override
  AsYouTypeSession createAsYouType(String regionCode) =>
      _EmptyOutputAsYouTypeSession();
}

void main() {
  group('LibPhoneAsYouTypeFormatter', () {
    test('formats digits via as-you-type session', () {
      final formatter = LibPhoneAsYouTypeFormatter(
        service: FakePhoneNumberService(),
        regionCode: 'US',
      );
      addTearDown(formatter.dispose);

      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: '4155'),
      );

      expect(result.text, '415 5');
    });

    test('appends incrementally without clearing the session', () {
      final service = FakePhoneNumberService();
      final formatter = LibPhoneAsYouTypeFormatter(
        service: service,
        regionCode: 'US',
      );
      addTearDown(formatter.dispose);

      formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: '4'),
      );
      final session = service.createdSessions.single;
      expect(session.clearCount, 0);

      formatter.formatEditUpdate(
        const TextEditingValue(text: '4'),
        const TextEditingValue(text: '41'),
      );
      expect(session.clearCount, 0);
      expect(
        formatter.formatEditUpdate(
          const TextEditingValue(text: '41'),
          const TextEditingValue(text: '415'),
        ).text,
        '415',
      );
    });

    test('rebuilds on backspace', () {
      final service = FakePhoneNumberService();
      final formatter = LibPhoneAsYouTypeFormatter(
        service: service,
        regionCode: 'US',
      );
      addTearDown(formatter.dispose);

      formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: '4155'),
      );
      final session = service.createdSessions.single;
      final clearsBefore = session.clearCount;

      formatter.formatEditUpdate(
        const TextEditingValue(text: '415 5'),
        const TextEditingValue(text: '415'),
      );

      expect(session.clearCount, greaterThan(clearsBefore));
      expect(
        formatter.formatEditUpdate(
          const TextEditingValue(text: '415'),
          const TextEditingValue(text: '415'),
        ).text,
        '415',
      );
    });

    test('keeps digits when session returns empty output', () {
      final formatter = LibPhoneAsYouTypeFormatter(
        service: _EmptyOutputPhoneNumberService(),
        regionCode: 'US',
      );
      addTearDown(formatter.dispose);

      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: '1'),
        const TextEditingValue(text: '12'),
      );

      expect(result.text, '12');
    });

    test('chained digits-only formatter keeps caret at end', () {
      final asYouType = LibPhoneAsYouTypeFormatter(
        service: FakePhoneNumberService(),
        regionCode: 'US',
      );
      addTearDown(asYouType.dispose);
      final digitsOnly =
          PhoneNumberDigitsOnlyFormatter(maskSplitCharacter: ' ');

      TextEditingValue apply(TextEditingValue old, TextEditingValue next) {
        final formatted = asYouType.formatEditUpdate(old, next);
        return digitsOnly.formatEditUpdate(old, formatted);
      }

      var value = TextEditingValue.empty;
      value = apply(value, const TextEditingValue(text: '4'));
      expect(value.selection.baseOffset, value.text.length);

      value = apply(value, TextEditingValue(
        text: '${value.text}1',
        selection: TextSelection.collapsed(offset: value.text.length + 1),
      ));
      expect(value.text, '41');
      expect(value.selection.baseOffset, 2);

      value = apply(value, TextEditingValue(
        text: '${value.text}5',
        selection: TextSelection.collapsed(offset: value.text.length + 1),
      ));
      expect(value.text, '415');
      expect(value.selection.baseOffset, 3);
    });
  });
}
