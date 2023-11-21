import 'package:ephone_field/src/utils/ephone_field_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'EphoneFieldUtils.combinePrefix should combine country dial code with phone number and remove mask split characters',
      () {
    const int prefix = 93;
    const String maskSplitCharacter = ' ';
    const String phoneNumber = '123 456 789';
    final String? result =
        EphoneFieldUtils.combinePrefix(prefix, phoneNumber, maskSplitCharacter);
    expect(result, '+93123456789');
  });

  test(
      'EphoneFieldUtils.combinePrefix should return null if phone number is null',
      () {
    const int prefix = 93;
    const String maskSplitCharacter = ' ';
    const String? phoneNumber = null;
    final String? result =
        EphoneFieldUtils.combinePrefix(prefix, phoneNumber, maskSplitCharacter);
    expect(result, null);
  });

  test(
      'EphoneFieldUtils.combinePrefix should return null if phone number is empty',
      () {
    const int prefix = 93;
    const String maskSplitCharacter = ' ';
    const String phoneNumber = '';
    final String? result =
        EphoneFieldUtils.combinePrefix(prefix, phoneNumber, maskSplitCharacter);
    expect(result, null);
  });
}
