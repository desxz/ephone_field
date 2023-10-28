import 'package:flutter/services.dart';

import '../formatters/formatters.dart';
import 'country.dart';

enum EPhoneTextFieldType { initial, email, phone }

extension EPhoneTextFielExtension on EPhoneTextFieldType {
  TextInputType get keyboardType {
    switch (this) {
      case EPhoneTextFieldType.initial:
        return TextInputType.text;
      case EPhoneTextFieldType.email:
        return TextInputType.emailAddress;
      case EPhoneTextFieldType.phone:
        return TextInputType.phone;
      default:
        return TextInputType.emailAddress;
    }
  }

  List<TextInputFormatter> inputFormatters(
      Country country, bool useMask, String maskSplitCharacter) {
    switch (this) {
      case EPhoneTextFieldType.initial:
        return [];
      case EPhoneTextFieldType.email:
        return [];
      case EPhoneTextFieldType.phone:
        return [
          useMask
              ? PhoneNumberMaskFormatter(
                  country: country, maskSplitCharacter: maskSplitCharacter)
              : LengthLimitingTextInputFormatter(country.maxLengthInt),
          PhoneNumberDigistOnlyFormatter(maskSplitCharacter: maskSplitCharacter)
        ];
      default:
        return [];
    }
  }

  String labelText(
      String emptyLabelText, String emailLabelText, String phoneLabelText) {
    switch (this) {
      case EPhoneTextFieldType.initial:
        return emptyLabelText;
      case EPhoneTextFieldType.email:
        return emailLabelText;
      case EPhoneTextFieldType.phone:
        return phoneLabelText;
      default:
        return emptyLabelText;
    }
  }
}
