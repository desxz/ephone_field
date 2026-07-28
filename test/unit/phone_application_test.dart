import 'package:ephone_field/src/application/phone/phone.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fake_phone_number_service.dart';

void main() {
  group('PhoneOutputMapper', () {
    test('prefers E.164 from service', () {
      final service = FakePhoneNumberService(
        e164ByRaw: {'TR|5321234567': '+905321234567'},
      );
      final mapper = PhoneOutputMapper(service);
      expect(
        mapper.mapForCallback(
          raw: '532 123 4567',
          regionCode: 'TR',
          dialCode: 90,
        ),
        '+905321234567',
      );
    });

    test('falls back to dial code concatenation', () {
      final mapper = PhoneOutputMapper(FakePhoneNumberService());
      expect(
        mapper.mapForCallback(
          raw: '532 123',
          regionCode: 'TR',
          dialCode: 90,
        ),
        '+90532123',
      );
    });

    test('returns null for empty raw', () {
      final mapper = PhoneOutputMapper(FakePhoneNumberService());
      expect(
        mapper.mapForCallback(raw: '', regionCode: 'TR', dialCode: 90),
        isNull,
      );
    });
  });

  group('PhoneInputSession', () {
    test('reuses session for same region and recreates on change', () {
      final service = FakePhoneNumberService();
      final input = PhoneInputSession(service);

      final first = input.forRegion('US');
      final same = input.forRegion('us');
      expect(identical(first, same), isTrue);
      expect(service.createdSessions, hasLength(1));

      final second = input.forRegion('TR');
      expect(identical(first, second), isFalse);
      expect((first as FakeAsYouTypeSession).disposed, isTrue);
      expect(service.createdSessions, hasLength(2));

      input.dispose();
      expect((second as FakeAsYouTypeSession).disposed, isTrue);
    });
  });
}
