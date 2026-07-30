import 'package:ephone_field/src/domain/phone/phone.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fake_phone_number_service.dart';

void main() {
  group('FakePhoneNumberService', () {
    late FakePhoneNumberService service;

    setUp(() {
      service = FakePhoneNumberService(
        validNumbers: {'US|4155552671'},
        possibleNumbers: {'US|415555'},
        e164ByRaw: {'US|4155552671': '+14155552671'},
        nationalByRaw: {'US|4155552671': '(415) 555-2671'},
        parseResults: {
          'US|4155552671': const PhoneParseResult(
            e164: '+14155552671',
            nationalNumber: '4155552671',
            countryCode: 1,
            regionCode: 'US',
          ),
        },
      );
    });

    test('isValid matches configured keys', () {
      expect(service.isValid('415-555-2671', regionCode: 'us'), isTrue);
      expect(service.isValid('4155550000', regionCode: 'US'), isFalse);
    });

    test('isPossible is true for possible or valid', () {
      expect(service.isPossible('415555', regionCode: 'US'), isTrue);
      expect(service.isPossible('4155552671', regionCode: 'US'), isTrue);
      expect(service.isPossible('1', regionCode: 'US'), isFalse);
    });

    test('parse and formatE164 return configured values', () {
      final parsed = service.parse('4155552671', regionCode: 'US');
      expect(parsed?.e164, '+14155552671');
      expect(
        service.formatE164('4155552671', regionCode: 'US'),
        '+14155552671',
      );
      expect(
        service.formatNational('4155552671', regionCode: 'US'),
        '(415) 555-2671',
      );
    });

    test('createAsYouType formats digit groups', () {
      final session = service.createAsYouType('US');
      expect(session.inputDigit('4'), '4');
      expect(session.inputDigit('1'), '41');
      expect(session.inputDigit('5'), '415');
      expect(session.inputDigit('5'), '415 5');
      session.clear();
      expect(session.inputDigit('9'), '9');
      session.dispose();
      expect((session as FakeAsYouTypeSession).disposed, isTrue);
    });
  });
}
