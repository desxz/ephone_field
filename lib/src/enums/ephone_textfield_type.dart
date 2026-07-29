import '../application/phone/phone_output_mapper.dart';
import 'package:flutter/services.dart';

import '../formatters/formatters.dart';
import 'country.dart';

/// Detects whether the current input should be treated as email or phone.
typedef EphoneFieldTypeResolver = EphoneFieldType Function(
  String text,
  EphoneFieldType initialType,
);

/// Default resolver: empty → [initialType], phone-like digits → phone, else email.
EphoneFieldType defaultEphoneFieldTypeResolver(
  String text,
  EphoneFieldType initialType,
) {
  final trimmed = text.trim();
  if (trimmed.isEmpty) {
    return initialType;
  }
  if (trimmed.contains('@')) {
    return EphoneFieldType.email;
  }
  final phonePattern = RegExp(r'^\+?[\d\s().\-]+$');
  if (phonePattern.hasMatch(trimmed)) {
    return EphoneFieldType.phone;
  }
  return EphoneFieldType.email;
}

String? _mapPhoneForCallback(
  String? value,
  Country country,
  PhoneOutputMapper mapper,
) =>
    mapper.mapForCallback(
      raw: value,
      regionCode: country.alpha2,
      dialCode: country.dialCode,
    );

/// Sets the type of the [EPhoneField] widget.
enum EphoneFieldType {
  /// Initial state before the user types.
  initial,

  /// Email input mode.
  email,

  /// Phone input mode.
  phone,
}

/// Extension methods for [EphoneFieldType] behavior.
extension EphoneFieldTypeExtension on EphoneFieldType {
  /// Returns the keyboard type for this field type.
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

  /// Returns input formatters for this field type (legacy mask path).
  List<TextInputFormatter> inputFormatters(
    Country country,
    String? maskSplitCharacter,
  ) {
    switch (this) {
      case EphoneFieldType.initial:
      case EphoneFieldType.email:
        return const [];
      case EphoneFieldType.phone:
        return [
          if (maskSplitCharacter != null)
            PhoneNumberMaskFormatter(
              country: country,
              maskSplitCharacter: maskSplitCharacter,
            )
          else
            LengthLimitingTextInputFormatter(country.maxLength),
          PhoneNumberDigitsOnlyFormatter(
              maskSplitCharacter: maskSplitCharacter),
        ];
    }
  }

  /// Returns the label text for this field type.
  String labelText(
    String emptyLabelText,
    String emailLabelText,
    String phoneLabelText,
  ) {
    switch (this) {
      case EphoneFieldType.initial:
        return emptyLabelText;
      case EphoneFieldType.email:
        return emailLabelText;
      case EphoneFieldType.phone:
        return phoneLabelText;
    }
  }

  /// Returns autofill hints for this field type.
  Iterable<String>? get autofillHints {
    switch (this) {
      case EphoneFieldType.initial:
        return null;
      case EphoneFieldType.email:
        return const [AutofillHints.email];
      case EphoneFieldType.phone:
        return const [AutofillHints.telephoneNumber];
    }
  }

  /// Returns the validator for this field type.
  ///
  /// Phone validators receive the mapped international value from [mapper].
  String? Function(String?)? validator(
    String? Function(String?)? typeValidator,
    Country country,
    PhoneOutputMapper mapper,
  ) {
    switch (this) {
      case EphoneFieldType.initial:
      case EphoneFieldType.email:
        return typeValidator;
      case EphoneFieldType.phone:
        return (value) => typeValidator?.call(
              _mapPhoneForCallback(value, country, mapper),
            );
    }
  }

  /// Returns the onFieldSubmitted callback for this field type.
  void Function(String?)? onFieldSubmitted(
    Country country,
    PhoneOutputMapper mapper,
    void Function(String?)? onFieldSubmitted,
  ) {
    switch (this) {
      case EphoneFieldType.initial:
      case EphoneFieldType.email:
        return onFieldSubmitted;
      case EphoneFieldType.phone:
        return (value) => onFieldSubmitted?.call(
              _mapPhoneForCallback(value, country, mapper),
            );
    }
  }

  /// Returns the onSaved callback for this field type.
  void Function(String?)? onSaved(
    Country country,
    PhoneOutputMapper mapper,
    void Function(String?)? onSaved,
  ) {
    switch (this) {
      case EphoneFieldType.initial:
      case EphoneFieldType.email:
        return onSaved;
      case EphoneFieldType.phone:
        return (value) => onSaved?.call(
              _mapPhoneForCallback(value, country, mapper),
            );
    }
  }

  /// Returns the onChanged callback for this field type.
  ///
  /// Phone mode passes national display text as typed; E.164 is reserved for
  /// [onSaved], [onFieldSubmitted], and validation.
  void Function(String)? onChanged(
    Country country,
    PhoneOutputMapper mapper,
    void Function(String)? onChanged,
  ) {
    switch (this) {
      case EphoneFieldType.initial:
      case EphoneFieldType.email:
        return onChanged;
      case EphoneFieldType.phone:
        return onChanged;
    }
  }
}
