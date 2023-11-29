import 'package:ephone_field/src/utils/ephone_field_utils.dart';
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
    }
  }

  List<TextInputFormatter> inputFormatters(Country country, bool useMask, String maskSplitCharacter) {
    switch (this) {
      case EphoneFieldType.initial:
        return [];
      case EphoneFieldType.email:
        return [];
      case EphoneFieldType.phone:
        return [
          useMask
              ? PhoneNumberMaskFormatter(country: country, maskSplitCharacter: maskSplitCharacter)
              : LengthLimitingTextInputFormatter(country.maxLength),
          PhoneNumberDigistOnlyFormatter(maskSplitCharacter: maskSplitCharacter)
        ];
    }
  }

  String labelText(String emptyLabelText, String emailLabelText, String phoneLabelText) {
    switch (this) {
      case EphoneFieldType.initial:
        return emptyLabelText;
      case EphoneFieldType.email:
        return emailLabelText;
      case EphoneFieldType.phone:
        return phoneLabelText;
    }
  }

  String? Function(String?)? validator(
      String? Function(String?)? typeValidator, Country country, String maskSplitCharacter) {
    switch (this) {
      case EphoneFieldType.initial:
        return typeValidator;
      case EphoneFieldType.email:
        return typeValidator;
      case EphoneFieldType.phone:
        return (value) =>
            typeValidator?.call(EphoneFieldUtils.combinePrefix(country.dialCode, value, maskSplitCharacter));
    }
  }

  void Function(String?)? onFieldSubmitted(
      Country country, String maskSplitCharacter, void Function(String?)? onFieldSubmitted) {
    switch (this) {
      case EphoneFieldType.initial:
        return onFieldSubmitted;
      case EphoneFieldType.email:
        return onFieldSubmitted;
      case EphoneFieldType.phone:
        return (value) =>
            onFieldSubmitted?.call(EphoneFieldUtils.combinePrefix(country.dialCode, value, maskSplitCharacter));
    }
  }

  void Function(String?)? onSaved(Country country, String maskSplitCharacter, void Function(String?)? onSaved) {
    switch (this) {
      case EphoneFieldType.initial:
        return onSaved;
      case EphoneFieldType.email:
        return onSaved;
      case EphoneFieldType.phone:
        return (value) => onSaved?.call(EphoneFieldUtils.combinePrefix(country.dialCode, value, maskSplitCharacter));
    }
  }

  void Function(String)? onChanged(Country country, String maskSplitCharacter, void Function(String)? onChanged) {
    switch (this) {
      case EphoneFieldType.initial:
        return onChanged;
      case EphoneFieldType.email:
        return onChanged;
      case EphoneFieldType.phone:
        return (value) => onChanged?.call(EphoneFieldUtils.combinePrefix(country.dialCode, value, maskSplitCharacter)!);
    }
  }
}
