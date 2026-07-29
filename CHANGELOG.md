## 0.0.3

* Converted the package into an Android/iOS Flutter FFI plugin with bundled Google
  libphonenumber (validation, E.164, AsYouType).
* Public API centered on `EPhoneField`, `Country` / picker enums, `CountryPickerConfig`,
  `EPhoneFieldLabels`, and `EmailValidators` / `PhoneValidators` / `Validators`.
* Default email (WHATWG-style) and phone validators when custom validators are omitted;
  `Validators.compose` / `andThen` for combining rules; `clearErrorOnChange` (default `true`).
* Practical `TextFormField` pass-through (`enabled`, `readOnly`, `autofocus`, cursor,
  scroll, `forceErrorText`, etc.); phone-mode IME defaults disable autocorrect/suggestions.
* Country picker: denser rows, themed search, full-width bottom sheet; emoji flags by
  default (`useFlagImages: false`); PNG flags optional via package `pubspec` assets.
* Native graph: always links libphonenumber; dropped ICU (~4 MB/arch stacks); iOS
  `ld -r` keeps only `ephone_*` globals; optional `ios/prebuilt/` + `tool/prebuild_ios.sh`.
* CI: Android/iOS smoke builds, iOS export assert, FetchContent cache, simulator prebuilt
  artifact on `main`.
* Requires Flutter `>=3.10.0` and Dart `>=3.0.0 <4.0.0`.
* Correctness and UX fixes from the unreleased tree: controller/focus ownership,
  `initialValue`, phone clear/`onChanged`, country data/mask alignment, picker a11y.

## 0.0.2

* Added page country picker type.
* Updated MaskSplitCharacter to be a string instead of a char.
* Split validators as emailValidator and phoneValidator.
* Fixed readme.md remote assets.
* Increased test coverage to 99%.
* Fixed Dart Version Problems
