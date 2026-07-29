import 'package:ephone_field/ephone_field.dart';
import 'package:ephone_field/src/validation/field_validator_resolver.dart';
import 'package:ephone_field/src/validation/validation_binding.dart';
import 'package:ephone_field/src/validation/validation_context.dart';
import 'package:ephone_field/src/infrastructure/phone/stub/unsupported_phone_number_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fake_phone_number_service.dart';

void main() {
  group('EmailValidators / EmailSyntax', () {
    test('accepts common and plus-addressing emails', () {
      expect(EmailValidators.email('user@example.com'), isNull);
      expect(EmailValidators.email('user+tag@gmail.com'), isNull);
      expect(EmailValidators.email('  a.b@c.co  '), isNull);
    });

    test('rejects blank, missing TLD, and garbage', () {
      expect(EmailValidators.email(null), 'Email is required');
      expect(EmailValidators.email(''), 'Email is required');
      expect(EmailValidators.email('not-an-email'), isNotNull);
      expect(EmailValidators.email('a@b'), isNotNull);
      expect(EmailValidators.email('user@localhost'), isNotNull);
    });

    test('rejects overlong addresses', () {
      final local = 'a' * 65;
      expect(EmailValidators.email('$local@example.com'), isNotNull);
      final long = '${'a' * 64}@${'b' * 190}.com';
      expect(long.length > EmailSyntax.maxAddressLength, isTrue);
      expect(EmailValidators.email(long), isNotNull);
    });
  });

  group('PhoneValidators', () {
    test('phoneWith uses PhoneNumberService when available', () {
      final context = ValidationContext(
        phoneService: FakePhoneNumberService(
          validNumbers: {'TR|5321234567'},
        ),
        country: Country.turkey,
      );
      expect(PhoneValidators.phoneWith(null, context), isNotNull);
      expect(PhoneValidators.phoneWith('5321234567', context), isNull);
      expect(PhoneValidators.phoneWith('111', context), isNotNull);
    });

    test('phoneWith falls back to country length for Unsupported', () {
      final context = ValidationContext(
        phoneService: const UnsupportedPhoneNumberService(),
        country: Country.turkey,
      );
      expect(PhoneValidators.phoneWith('5321234567', context), isNull);
      expect(PhoneValidators.phoneWith('12', context), isNotNull);
    });

    test('phone reads ValidationBinding', () {
      final context = ValidationContext(
        phoneService: FakePhoneNumberService(
          validNumbers: {'US|4155552671'},
        ),
        country: Country.unitedStates,
      );
      ValidationBinding.run(context, () {
        expect(PhoneValidators.phone('4155552671'), isNull);
        expect(PhoneValidators.phone('1'), isNotNull);
      });
    });

    test('phone throws without binding', () {
      expect(() => PhoneValidators.phone('1'), throwsStateError);
    });
  });

  group('Validators.compose', () {
    test('email compose runs package then extra', () {
      final composed = Validators.compose([
        EmailValidators.email,
        (value) => value != null && value.endsWith('@blocked.com')
            ? 'Domain not allowed'
            : null,
      ]);
      expect(composed('bad'), isNotNull);
      expect(composed('user@blocked.com'), 'Domain not allowed');
      expect(composed('user@ok.com'), isNull);
    });

    test('phone compose with binding', () {
      final context = ValidationContext(
        phoneService: FakePhoneNumberService(
          validNumbers: {'TR|55544445544'},
        ),
        country: Country.turkey,
      );
      final composed = Validators.compose([
        PhoneValidators.phone,
        (value) {
          final digits = value?.replaceAll(RegExp(r'\D'), '') ?? '';
          if (digits.endsWith('55544445544')) {
            return 'This number is not allowed';
          }
          return null;
        },
      ]);
      ValidationBinding.run(context, () {
        expect(composed('111'), isNotNull);
        expect(composed('55544445544'), 'This number is not allowed');
      });
    });
  });

  group('resolveFieldValidator', () {
    final context = ValidationContext(
      phoneService: FakePhoneNumberService(validNumbers: {'US|4155552671'}),
      country: Country.unitedStates,
      emptyErrorText: 'Required',
    );

    test('email null user → package default', () {
      final v = resolveFieldValidator(
        EphoneFieldType.email,
        userValidator: null,
        context: context,
      );
      expect(v!('bad'), isNotNull);
      expect(v('user@mail.com'), isNull);
    });

    test('phone null user → PhoneValidators.phone under binding', () {
      final v = resolveFieldValidator(
        EphoneFieldType.phone,
        userValidator: null,
        context: context,
      );
      ValidationBinding.run(context, () {
        expect(v!('4155552671'), isNull);
        expect(v('1'), isNotNull);
      });
    });
  });
}
