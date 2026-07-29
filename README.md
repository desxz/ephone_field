# EphoneField

[![Github](https://img.shields.io/badge/github-desxz/ephone_field-purple.svg)](https://github.com/desxz/ephone_field)
[![pub package](https://img.shields.io/pub/v/ephone_field.svg)](https://pub.dev/packages/ephone_field)
[![Build Status](https://github.com/desxz/ephone_field/actions/workflows/main.yaml/badge.svg)](https://github.com/desxz/ephone_field/actions/workflows/main.yaml)
[![codecov](https://codecov.io/gh/desxz/ephone_field/graph/badge.svg?branch=main)](https://codecov.io/gh/desxz/ephone_field)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

A Flutter `TextFormField` for email **or** phone input in one field, with country
picking and Google libphonenumber on Android/iOS.

## Features

- Auto-detects email vs phone as the user types
- Phone AsYouType formatting and validation via bundled libphonenumber (FFI)
- Country picker (bottom sheet, dialog, or full page)
- Package default validators, or compose your own with `Validators.compose`
- Emoji country flags by default (optional PNG assets)

## Requirements

- Flutter `>=3.10.0`, Dart `>=3.0.0 <4.0.0`
- **Android and iOS only** (FFI plugin). Web/desktop are not supported; without
  native libphonenumber, phone checks fall back to country length/mask metadata.

### Native build note

The first Android/iOS build compiles Abseil, protobuf-lite, RE2, and libphonenumber
with CMake (network once for FetchContent). On iOS, install CMake
(`brew install cmake`) or place a prebuilt stack in `ios/prebuilt/`
(see `tool/prebuild_ios.sh` and [doc/ARCHITECTURE.md](doc/ARCHITECTURE.md)).

## Install

```yaml
dependencies:
  ephone_field: ^0.0.3
```

```dart
import 'package:ephone_field/ephone_field.dart';
```

## Usage

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

When `emailValidator` / `phoneValidator` are omitted, package defaults run.

```dart
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
```

- Phone `onChanged` receives **national display** text.
- E.164 mapping is used for `onSaved`, `onFieldSubmitted`, and phone validation.
- Set `clearErrorOnChange: false` if you want sticky errors until the next
  `Form.validate()`.

### Country flags

By default flags are emoji (`CountryPickerConfig.useFlagImages` is `false`).
To use PNGs, declare the assets in **this package’s** `pubspec.yaml` and set
`useFlagImages: true` (see comments in `pubspec.yaml`).

### Country picker screenshots

| Dialog | Bottom sheet | Page |
| --- | --- | --- |
| <img src="https://raw.githubusercontent.com/desxz/ephone_field/main/ephone-field-dialog.png" width="280"> | <img src="https://raw.githubusercontent.com/desxz/ephone_field/main/ephone-field-bottomsheet.png" width="280"> | <img src="https://raw.githubusercontent.com/desxz/ephone_field/main/ephone-field-page.png" width="280"> |

<img src="https://raw.githubusercontent.com/desxz/ephone_field/main/ephone-field-show.gif" width="512">

## Properties

| Property | Description | Type | Default |
| --- | --- | --- | --- |
| controller | Text editing controller | `TextEditingController?` | `null` |
| focusNode | Focus node | `FocusNode?` | `null` |
| initialValue | Initial text when no controller | `String?` | `null` |
| initialType | Type before user types | `EphoneFieldType` | `initial` |
| initialCountry | Default country | `Country` | `Country.unitedStates` |
| countryPicker | Picker presentation and list | `CountryPickerConfig` | bottom sheet, searchable |
| labels | Field labels and empty error | `EPhoneFieldLabels` | English defaults |
| decoration | Input decoration | `InputDecoration` | outlined |
| autovalidateMode | Form autovalidate | `AutovalidateMode?` | `null` |
| clearErrorOnChange | Clear error on text/country edit after failed validate | `bool` | `true` |
| enabled / readOnly / autofocus | Interaction flags | `bool` | `true` / `false` / `false` |
| textInputAction | Keyboard action | `TextInputAction?` | `null` |
| textDirection / textAlignVertical | Text layout | optional | `null` |
| autocorrect / enableSuggestions | IME; phone defaults off | `bool?` | type-aware |
| forceErrorText / errorBuilder | External validation UI | optional | `null` |
| onChanged / onSaved / onFieldSubmitted | Form callbacks | callbacks | `null` |
| onCountryChanged / onTypeChanged | Domain callbacks | callbacks | `null` |
| emailValidator / phoneValidator | Custom validators | `FormFieldValidator?` | package defaults |
| inputFormatters | Override formatters | `List<TextInputFormatter>?` | phone/email defaults |
| typeResolver | Email vs phone detection | `EphoneFieldTypeResolver` | built-in |

`CountryPickerConfig` groups `menuType`, `pickerHeight`, `isSearchable`, `title`,
`buttonIcon`, `buttonWidth`, `countries`, and `useFlagImages`.

## Maintainers

Bump vendored slim libphonenumber sources:

```bash
./tool/upgrade_libphonenumber.sh
```

See [doc/ARCHITECTURE.md](doc/ARCHITECTURE.md) for the native build graph and
prebuild workflow.
