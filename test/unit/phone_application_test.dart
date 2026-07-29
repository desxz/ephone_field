import 'package:ephone_field/src/application/phone/phone_output_mapper.dart';
import 'package:ephone_field/src/formatters/lib_phone_as_you_type_formatter.dart';
import 'package:flutter/services.dart';
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

  group('LibPhoneAsYouTypeFormatter region session', () {
    test('reuses session for same region and recreates on change', () {
      final service = FakePhoneNumberService();
      final formatter = LibPhoneAsYouTypeFormatter(
        service: service,
        regionCode: 'US',
      );

      formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '4'),
      );
      expect(service.createdSessions, hasLength(1));

      formatter.formatEditUpdate(
        const TextEditingValue(text: '4'),
        const TextEditingValue(text: '41'),
      );
      expect(service.createdSessions, hasLength(1));

      formatter.updateRegion('TR');
      expect((service.createdSessions.first).disposed, isTrue);
      expect(service.createdSessions, hasLength(1));

      formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '5'),
      );
      expect(service.createdSessions, hasLength(2));

      formatter.dispose();
      expect(service.createdSessions.last.disposed, isTrue);
    });
  });
}
