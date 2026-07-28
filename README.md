# EphoneField
  
  [![Github](https://img.shields.io/badge/github-desxz/ephone_field-purple.svg)](https://github.com/desxz/ephone_field)
  [![pub package](https://img.shields.io/pub/v/ephone_field.svg)](https://pub.dartlang.org/packages/ephone_field)
  [![Build Status](https://github.com/desxz/ephone_field/actions/workflows/main.yaml/badge.svg)](https://github.com/desxz/ephone_field/actions/workflows/main.yaml)
  [![codecov](https://codecov.io/gh/desxz/ephone_field/graph/badge.svg?branch=main)](https://codecov.io/gh/desxz/ephone_field)
  [![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

A versatile Flutter TextFormField widget for handling email and phone number input with ease.

This custom TextField package simplifies the process of capturing email and phone number input
in your Flutter applications. It offers real-time validation and user-friendly error handling (in dev),
making it a valuable addition to any form or input-focused application. Whether you're building
a sign-up form, a contact input screen, or anything in between, this package can save you time
and effort by handling the intricacies of email and phone number input for you.

## Features

- Versatile: Handles email and phone number input
- Masking: Automatically formats phone numbers as they are entered
- Customizable: Customize the appearance of the widget to fit your application
- Easy to use: Simply add the widget to your UI and let it handle the rest
- Error handling: Provides real-time validation and user-friendly error handling (in dev)
- Tested: Unit tests ensure that the widget works as expected

## Getting started

**Requirements:** Flutter 3.10+ and Dart 3.0+. This package is a **Flutter plugin** (FFI on Android/iOS).

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ephone_field: ^0.2.0
```

Import it:

```dart
import 'package:ephone_field/ephone_field.dart';
```

## Usage

When `emailValidator` / `phoneValidator` are omitted, **package defaults** run.

```dart
// Defaults on
EPhoneField()

// Package rules + your extra conditions (compose) — no PhoneNumberService to set
EPhoneField(
  emailValidator: Validators.compose([
    EmailValidators.email,
    (value) => value != null && value.endsWith('@blocked.com')
        ? 'Domain not allowed'
        : null,
  ]),
  phoneValidator: Validators.compose([
    PhoneValidators.phone,
    (value) => value == '05554445544' ? 'This number is not allowed' : null,
  ]),
)

// Disable validation for a mode
EPhoneField(
  emailValidator: (_) => null,
  phoneValidator: (_) => null,
)
```

Phone formatting uses Google **libphonenumber** AsYouType on Android/iOS (bundled with the plugin). Legacy mask formatting is used only when native libphonenumber is unavailable (for example unit tests without the plugin, or web).

Maintainers can bump the vendored slim sources with:

```bash
./tool/upgrade_libphonenumber.sh
```

<img src="https://raw.githubusercontent.com/desxz/ephone_field/main/ephone-field-show.gif" width="512">

### EphoneField Country Picker Widgets

| Dialog   | Bottom Sheet | Page     
|---------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------|---|
| <img src="https://raw.githubusercontent.com/desxz/ephone_field/main/ephone-field-dialog.png" width="280"> | <img src="https://raw.githubusercontent.com/desxz/ephone_field/main/ephone-field-bottomsheet.png" width="280"> | <img src="https://raw.githubusercontent.com/desxz/ephone_field/main/ephone-field-page.png" width="280"> |


## Additional information

| Property                 | Description                                  | Type                              | Default                                 |
| ------------------------ | -------------------------------------------- | --------------------------------- | --------------------------------------- |
| key                      | The key for the input field.                 | `Key?`                            | `null`                                  |
| initialType              | The initial type of the input field.         | `EphoneFieldType`                 | `EphoneFieldType.initial`               |
| countries                | The list of countries to display.            | `List<Country>`                   | `Country.values`                        |
| controller               | The controller for the input field.          | `TextEditingController?`          | `null`                                  |
| focusNode                | The focus node for the input field.          | `FocusNode?`                      | `null`                                  |
| decoration               | The decoration for the input field.          | `InputDecoration`                 | `InputDecoration(border: OutlineInputBorder())` |
| searchInputDecoration    | The decoration for the search input field.   | `InputDecoration`                 | search field defaults                   |
| isSearchable             | Whether the search input is enabled.         | `bool`                            | `true`                                  |
| title                    | The title for the country picker.            | `String?`                         | `null`                                  |
| titlePadding             | The padding for the title of country picker. | `EdgeInsetsGeometry`              | `EdgeInsets.all(8.0)`                   |
| pickerHeight             | The height of the country picker.            | `CountryPickerHeight`             | `CountryPickerHeight.h50`               |
| menuType                 | The type of the picker menu.                 | `PickerMenuType`                  | `PickerMenuType.bottomSheet`            |
| initialCountry           | The initial country of country picker.       | `Country`                         | `Country.unitedStates`                  |
| initialValue             | The initial value when no controller is set. | `String?`                         | `null`                                  |
| emptyLabelText           | The label text when the input is empty.      | `String`                          | `Email or phone number`                 |
| emailLabelText           | The label text when the field type is email. | `String`                          | `Email`                                 |
| phoneLabelText           | The label text when the field type is phone. | `String`                          | `Phone number`                          |
| countryPickerButtonIcon  | The icon for the country picker button.      | `IconData`                        | `Icons.arrow_drop_down`                 |
| phoneNumberMaskSplitter  | The splitter for the phone number mask.      | `String?`                         | `' '`                                   |
| countryPickerButtonWidth | The minimum width of the country picker button. | `double`                       | `108.0`                                 |
| autovalidateMode         | The autovalidate mode of the input field.    | `AutovalidateMode?`               | `null`                                  |
| emptyErrorText           | Error text for empty initial-state input.    | `String?`                         | `null`                                  |
| onChanged                | The callback when the input value changes.   | `void Function(String)?`          | `null`                                  |
| onSaved                  | The callback when the input is saved.        | `void Function(String?)?`         | `null`                                  |
| onFieldSubmitted         | The callback when the input is submitted.    | `void Function(String?)?`         | `null`                                  |
| onCountryChanged         | The callback when the country is changed.    | `ValueChanged<Country>?`          | `null`                                  |
| onTypeChanged            | The callback when the detected type changes. | `ValueChanged<EphoneFieldType>?`  | `null`                                  |
| emailValidator           | The validator for the email input field.     | `String? Function(String?)?`     | `null`                                  |
| phoneValidator           | The validator for the phone input field.     | `String? Function(String?)?`     | `null`                                  |
| inputFormatters          | The input formatters for the input field.    | `List<TextInputFormatter>?`      | phone/email defaults                    |
| typeResolver             | Custom email/phone detection strategy.       | `EphoneFieldTypeResolver`         | `defaultEphoneFieldTypeResolver`        |