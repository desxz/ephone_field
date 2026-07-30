import 'package:ephone_field/src/domain/phone/phone.dart';
import 'package:ephone_field/src/formatters/lib_phone_as_you_type_formatter.dart';
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
  _EmptyOutputPhoneNumberService() : super(supportsAsYouTypeFormatting: true);

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
        formatter
            .formatEditUpdate(
              const TextEditingValue(text: '41'),
              const TextEditingValue(text: '415'),
            )
            .text,
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
        formatter
            .formatEditUpdate(
              const TextEditingValue(text: '415'),
              const TextEditingValue(text: '415'),
            )
            .text,
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

    test('preserves caret by digit index on mid-string edit', () {
      final formatter = LibPhoneAsYouTypeFormatter(
        service: FakePhoneNumberService(),
        regionCode: 'US',
      );
      addTearDown(formatter.dispose);

      // Build "415 5"
      formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: '4155'),
      );

      // Insert '9' after first digit: digits "49155" with caret after "49"
      final result = formatter.formatEditUpdate(
        const TextEditingValue(
          text: '415 5',
          selection: TextSelection.collapsed(offset: 1),
        ),
        const TextEditingValue(
          text: '4915 5',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );

      expect(result.text.replaceAll(RegExp(r'\D'), ''), '49155');
      // Caret stays after 2 digits, not forced to end.
      final digitsBefore =
          result.text
              .substring(0, result.selection.baseOffset)
              .replaceAll(RegExp(r'\D'), '')
              .length;
      expect(digitsBefore, 2);
      expect(result.selection.baseOffset, lessThan(result.text.length));
    });

    test('formatDigits rebuilds for a new region', () {
      final formatter = LibPhoneAsYouTypeFormatter(
        service: FakePhoneNumberService(),
        regionCode: 'US',
      );
      addTearDown(formatter.dispose);

      expect(formatter.formatDigits('4155'), '415 5');
      formatter.updateRegion('TR');
      expect(formatter.formatDigits('532'), '532');
    });
  });
}
