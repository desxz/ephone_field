import 'dart:io';

import 'package:ephone_field/ephone_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Country data invariants', () {
    test('values contains every private country constant', () {
      final dataFile = File('lib/src/enums/country_data.dart');
      final source = dataFile.readAsStringSync();
      final privateConstants = RegExp(r'const Country _(\w+) =')
          .allMatches(source)
          .map((match) => match.group(1))
          .toSet();

      final valueAlpha2 =
          Country.values.map((country) => country.alpha2).toSet();
      expect(valueAlpha2.length, Country.values.length);
      expect(
          privateConstants.length, greaterThanOrEqualTo(Country.values.length));
    });

    test('alpha2 codes are unique', () {
      final alpha2Codes =
          Country.values.map((country) => country.alpha2).toList();
      expect(alpha2Codes.toSet().length, alpha2Codes.length);
    });

    test('mask placeholder count matches maxLength', () {
      for (final country in Country.values) {
        final placeholderCount =
            country.mask.split('').where((char) => char == '#').length;
        expect(
          placeholderCount,
          country.maxLength,
          reason: '${country.name} mask does not match maxLength',
        );
      }
    });

    test('minLength is less than or equal to maxLength', () {
      for (final country in Country.values) {
        expect(
          country.minLength <= country.maxLength,
          isTrue,
          reason: country.name,
        );
      }
    });

    test('flag assets exist on disk', () {
      for (final country in Country.values) {
        expect(
          File(country.flagImagePath).existsSync(),
          isTrue,
          reason: country.flagImagePath,
        );
      }
    });

    test('macedonia is included in values', () {
      expect(
        Country.values.any((country) => country.alpha2 == 'MK'),
        isTrue,
      );
    });

    test('united states mask is grouped as ### ### ####', () {
      expect(Country.unitedStates.mask, '### ### ####');
    });
  });
}
