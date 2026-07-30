import 'package:ephone_field/src/application/phone/phone_output_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dialCodeFallback combines dial code and strips separators', () {
    expect(
      PhoneOutputMapper.dialCodeFallback(raw: '123 456 789', dialCode: 93),
      '+93123456789',
    );
  });

  test('dialCodeFallback returns null for empty input', () {
    expect(PhoneOutputMapper.dialCodeFallback(raw: '', dialCode: 93), isNull);
  });

  test('dialCodeFallback strips non-digit characters', () {
    expect(
      PhoneOutputMapper.dialCodeFallback(raw: '(222) 333-4444', dialCode: 1),
      '+12223334444',
    );
  });

  test('dialCodeFallback strips leading dial code for international paste', () {
    expect(
      PhoneOutputMapper.dialCodeFallback(raw: '+1 415 555 2671', dialCode: 1),
      '+14155552671',
    );
    expect(
      PhoneOutputMapper.dialCodeFallback(
        raw: '00 90 532 123 4567',
        dialCode: 90,
      ),
      '+905321234567',
    );
  });

  test('dialCodeFallback still prepends for national digits', () {
    expect(
      PhoneOutputMapper.dialCodeFallback(raw: '4155552671', dialCode: 1),
      '+14155552671',
    );
  });
}
