import 'package:ephone_field/src/domain/phone/phone.dart';
import 'package:ephone_field/src/formatting/lib_phone_as_you_type_formatter.dart';
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
  });
}
