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

Install, import, drop in a form — defaults handle validation and phone formatting on Android/iOS:

```dart
Form(
  child: EPhoneField(
    initialCountry: Country.turkey,
    countryPicker: const CountryPickerConfig(
      menuType: PickerMenuType.bottomSheet,
      title: 'Select Country',
    ),
    labels: const EPhoneFieldLabels(phone: 'Phone number'),
    textInputAction: TextInputAction.done,
  ),
)
```

When `emailValidator` / `phoneValidator` are omitted, **package defaults** run.

```dart
// Package rules + your extra conditions (compose)
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

`onChanged` receives national display text for phone mode. E.164 mapping is used for `onSaved`, `onFieldSubmitted`, and phone validation.

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

| Property | Description | Type | Default |
| --- | --- | --- | --- |
| controller | Text editing controller | `TextEditingController?` | `null` |
| focusNode | Focus node | `FocusNode?` | `null` |
| initialValue | Initial text when no controller | `String?` | `null` |
| initialType | Type before user types | `EphoneFieldType` | `initial` |
| initialCountry | Default country | `Country` | `Country.unitedStates` |
| countryPicker | Picker presentation & list | `CountryPickerConfig` | bottom sheet, searchable |
| labels | Field labels & empty error | `EPhoneFieldLabels` | English defaults |
| decoration | Input decoration | `InputDecoration` | outlined |
| autovalidateMode | Form autovalidate | `AutovalidateMode?` | `null` |
| clearErrorOnChange | Clear error on text/country edit after failed validate | `bool` | `true` |
| enabled / readOnly / autofocus | Interaction flags | `bool` | `true` / `false` / `false` |
| textInputAction | Keyboard action | `TextInputAction?` | `null` |
| textDirection / textAlignVertical | Text layout | optional | `null` |
| autocorrect / enableSuggestions | IME behavior; phone defaults off | `bool?` | type-aware |
| forceErrorText / errorBuilder | External validation UI | optional | `null` |
| onChanged / onSaved / onFieldSubmitted | Form callbacks | callbacks | `null` |
| onCountryChanged / onTypeChanged | Domain callbacks | callbacks | `null` |
| emailValidator / phoneValidator | Custom validators | `FormFieldValidator?` | package defaults |
| inputFormatters | Override formatters | `List<TextInputFormatter>?` | phone/email defaults |
| typeResolver | Email vs phone detection | `EphoneFieldTypeResolver` | built-in |

`CountryPickerConfig` groups `menuType`, `pickerHeight`, `isSearchable`, `title`, `buttonIcon`, `buttonWidth`, and `countries`.