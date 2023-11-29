import 'package:ephone_field/src/utils/ephone_field_utils.dart';
import 'package:flutter/services.dart';

import '../formatters/formatters.dart';
import 'country.dart';

/// This enum is used to set the type of the [EphoneField]
enum EphoneFieldType { initial, email, phone }

/// This extension is used to get the type of the [EphoneField]
/// based on the [EphoneFieldType] enum
extension EPhoneTextFielExtension on EphoneFieldType {
  /// Returns the keyboard type of the [EphoneField] based on the [EphoneFieldType] enum
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

  /// Returns the input formatters of the [EphoneField] based on the [EphoneFieldType] enum
  /// Given the [Country] and the [useMask] boolean
  /// If [useMask] is true, the [PhoneNumberMaskFormatter] will be used
  /// If [useMask] is false, the [LengthLimitingTextInputFormatter] will be used
  /// In both cases, the [PhoneNumberDigistOnlyFormatter] will be used
  List<TextInputFormatter> inputFormatters(Country country, String? maskSplitCharacter) {
    switch (this) {
      case EphoneFieldType.initial:
        return [];
      case EphoneFieldType.email:
        return [];
      case EphoneFieldType.phone:
        return [
          maskSplitCharacter != null
              ? PhoneNumberMaskFormatter(country: country, maskSplitCharacter: maskSplitCharacter)
              : LengthLimitingTextInputFormatter(country.maxLength),
          PhoneNumberDigistOnlyFormatter(maskSplitCharacter: maskSplitCharacter)
        ];
    }
  }

  /// Returns the label text of the [EphoneField] based on the [EphoneFieldType] enum
  /// Given the [emptyLabelText], [emailLabelText] and [phoneLabelText]
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

  /// Returns the hint text of the [EphoneField] based on the [EphoneFieldType] enum
  /// Given the [validator], [Country] and [maskSplitCharacter]
  String? Function(String?)? validator(
      String? Function(String?)? typeValidator, Country country, String? maskSplitCharacter) {
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

  /// Returns the hint text of the [EphoneField] based on the [EphoneFieldType] enum
  /// Given the [Country], [maskSplitCharacter] and [onFieldSubmitted]
  void Function(String?)? onFieldSubmitted(
      Country country, String? maskSplitCharacter, void Function(String?)? onFieldSubmitted) {
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

  /// Returns the hint text of the [EphoneField] based on the [EphoneFieldType] enum
  /// Given the [Country], [maskSplitCharacter] and [onSaved]
  void Function(String?)? onSaved(Country country, String? maskSplitCharacter, void Function(String?)? onSaved) {
    switch (this) {
      case EphoneFieldType.initial:
        return onSaved;
      case EphoneFieldType.email:
        return onSaved;
      case EphoneFieldType.phone:
        return (value) => onSaved?.call(EphoneFieldUtils.combinePrefix(country.dialCode, value, maskSplitCharacter));
    }
  }

  /// Returns the hint text of the [EphoneField] based on the [EphoneFieldType] enum
  /// Given the [Country], [maskSplitCharacter] and [onChanged]
  void Function(String)? onChanged(Country country, String? maskSplitCharacter, void Function(String)? onChanged) {
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
