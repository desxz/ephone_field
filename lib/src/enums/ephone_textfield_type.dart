import 'package:flutter/services.dart';

import '../formatters/formatters.dart';
import 'country.dart';

enum EphoneFieldType { initial, email, phone }

extension EPhoneTextFielExtension on EphoneFieldType {
  TextInputType get keyboardType {
    switch (this) {
      case EphoneFieldType.initial:
        return TextInputType.text;
      case EphoneFieldType.email:
        return TextInputType.emailAddress;
      case EphoneFieldType.phone:
        return TextInputType.phone;
      default:
        return TextInputType.emailAddress;
    }
  }

  List<TextInputFormatter> inputFormatters(
      Country country, bool useMask, String maskSplitCharacter) {
    switch (this) {
      case EphoneFieldType.initial:
        return [];
      case EphoneFieldType.email:
        return [];
      case EphoneFieldType.phone:
        return [
          useMask
              ? PhoneNumberMaskFormatter(
                  country: country, maskSplitCharacter: maskSplitCharacter)
              : LengthLimitingTextInputFormatter(country.maxLength),
          PhoneNumberDigistOnlyFormatter(maskSplitCharacter: maskSplitCharacter)
        ];
      default:
        return [];
    }
  }

  String labelText(
      String emptyLabelText, String emailLabelText, String phoneLabelText) {
    switch (this) {
      case EphoneFieldType.initial:
        return emptyLabelText;
      case EphoneFieldType.email:
        return emailLabelText;
      case EphoneFieldType.phone:
        return phoneLabelText;
      default:
        return emptyLabelText;
    }
  }
}
