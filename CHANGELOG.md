## 0.0.3

* Converted the package into an Android/iOS Flutter FFI plugin with bundled Google
  libphonenumber (validation, E.164, AsYouType).
* Public API centered on `EPhoneField`, `Country` / picker enums, `CountryPickerConfig`,
  `EPhoneFieldLabels`, and `EmailValidators` / `PhoneValidators` / `Validators`.
* Default email (WHATWG-style) and phone validators when custom validators are omitted;
  `Validators.compose` / `andThen` for combining rules; `clearErrorOnChange` (default `true`).
* Practical `TextFormField` pass-through (`enabled`, `readOnly`, `autofocus`, cursor,
  scroll, `forceErrorText`, etc.); phone-mode IME defaults disable autocorrect/suggestions.
* Country picker: denser rows, themed search, full-width bottom sheet; PNG flag
  images by default (`useFlagImages: true`); set `false` for emoji-only.
* Native graph: always links libphonenumber; dropped ICU; iOS `ld -r` keeps only
  `ephone_*` globals.
* **Zero-friction install:** ships prebuilt iOS stacks (`ios/prebuilt/`) and Android
  `jniLibs` (arm64-v8a / armeabi-v7a / x86_64). Consumers need no CMake or extra
  commands — `flutter pub add` only. Maintainer rebuild: `tool/prebuild_all.sh`.
* Slimmed vendored LPN tree (no metadata/geocoding/carrier/test resources); excluded
  from the pub tarball when prebuilts are present.
* CI: assert shipped prebuilts; Android/iOS smoke; iOS export assert on CMake fallback.
* Requires Flutter `>=3.27.0` and Dart `>=3.6.0 <4.0.0` (TextFormField / Color APIs used by the package).
* Correctness and UX fixes from the unreleased tree: controller/focus ownership,
  `initialValue`, phone clear/`onChanged`, country data length alignment, picker a11y.
* **Breaking:** removed deprecated aliases (`Country.macedonia` / `swaziland`,
  `CountryPickerHeigth`, `PhoneNumberDigistOnlyFormatter`).
* **Breaking:** removed `PhoneNumberMaskFormatter`, `EPhoneField.phoneNumberMaskSplitter`,
  and `Country.mask`. Without native AsYouType, phone input uses length limit + digits-only.
* Must-fix: disabled/readOnly blocks country picker; dial-code fallback no longer doubles
  pasted international numbers; dialog picker height overflow; controller swap resyncs type;
  AsYouType caret preservation; country change reformats; digit-count length limit; FFI
  dispose idempotent; `parse()` returns real country code; AsYouType accepts Unicode code
  points; clear errors when prebuilts are missing from a published layout.

## 0.0.2

* Added page country picker type.
* Updated MaskSplitCharacter to be a string instead of a char.
* Split validators as emailValidator and phoneValidator.
* Fixed readme.md remote assets.
* Increased test coverage to 99%.
* Fixed Dart Version Problems
