import 'package:ephone_field/ephone_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'combinePrefix combines dial code and strips separators',
    () {
      final result = EphoneFieldUtils.combinePrefix(93, '123 456 789', ' ');
      expect(result, '+93123456789');
    },
  );

  test('combinePrefix returns null for null input', () {
    expect(EphoneFieldUtils.combinePrefix(93, null, ' '), isNull);
  });

  test('combinePrefix returns null for empty input', () {
    expect(EphoneFieldUtils.combinePrefix(93, '', ' '), isNull);
  });

  test('combinePrefix strips non-digit characters', () {
    expect(
      EphoneFieldUtils.combinePrefix(1, '(222) 333-4444', ' '),
      '+12223334444',
    );
  });
}
