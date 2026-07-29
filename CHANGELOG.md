## 0.2.0

* Converted the package into a Flutter FFI plugin (`android` / `ios`) with a C API around phone capabilities.
* Introduced Ports & Adapters layout: `domain/phone`, `application/phone`, `infrastructure/phone`, `validation/`, `formatters/`.
* Added internal `PhoneNumberService` port, factory, and FFI/unsupported stubs (not part of the consumer validation API).
* Default email/phone validators when custom validators are omitted (HTML5/WHATWG email; phone via internal `PhoneNumberService` with country-length fallback).
* Added `Validators.compose` / `andThen` so package rules can be combined with user conditions.
* `PhoneValidators.phone` matches `EmailValidators.email` (no service/country to pass); context is bound internally by `EPhoneField`.
* Removed public `phoneNumberService` injection; phone capability is owned by the plugin (`debugPhoneNumberService` is test-only).
* Added `EmailValidators` / `PhoneValidators` for explicit compose/override.
* **Slimmed public API:** `EPhoneField`, enums, and validators only. Removed exports of `PhoneNumberService`, `PhoneOutputMapper`, `FieldValidationPolicy`, `ValidationBinding`, formatters, and deprecated utils.
* **Performance:** incremental AsYouType formatting (no full clear+re-feed on every keystroke); phone `onChanged` passes national display text instead of calling E.164 FFI per keystroke.
* **iOS:** universal static archive build, protobuf lite/lited selection, simulator link fixes.
* Deprecated `PhoneNumberMaskFormatter` (legacy mask path kept as fallback when native is unavailable).
* Added slim libphonenumber upgrade script (`tool/upgrade_libphonenumber.sh`) and version pin (`third_party/LIBPHONENUMBER_VERSION`). Android/iOS production builds **always link Google libphonenumber**.
* **Compact API:** `CountryPickerConfig` and `EPhoneFieldLabels` group picker/label settings; practical `TextFormField` params (`enabled`, `readOnly`, `textInputAction`, cursor, etc.) exposed flat.
* **Country picker UI:** denser country rows, themed search field, rounded dialog; full-width bottom sheet on all screen sizes.
* **TextFormField parity:** extended pass-through (`autofocus`, `textDirection`, `forceErrorText`, `contextMenuBuilder`, scroll/cursor/tap params); phone-mode defaults disable autocorrect/suggestions; validator now resolves type from submitted value.
* **Validation UX:** `clearErrorOnChange` (default `true`) clears the error as soon as the user edits text or changes country after a failed validate; set `false` for sticky errors until the next `Form.validate()`.
* **Install honesty:** public platforms limited to Android/iOS; README documents native CMake requirements; architecture roadmap in `docs/ARCHITECTURE.md`; iOS smoke job in CI.
* **Internal cleanup:** `supportsNativeValidation` port flag (no stub type checks in validation); AsYouType session inlined into formatter; `resolveFieldValidator` lives in `Validators`; FFI util disposed with the widget.
* **Native graph:** removed unused `EPHONE_USE_LIBPHONENUMBER=OFF` stub path (single production CMake path).
* **Flags:** `CountryPickerConfig.useFlagImages` defaults to `false` (emoji). PNG flags under `assets/flags/` are kept in the repo but not bundled unless you re-add them to the package `pubspec` and set `useFlagImages: true`.
* **Native CI:** caches iOS FetchContent deps; uploads simulator prebuilt stack artifact on `main`; asserts only `ephone_*` globals are exported.
* **Native size:** dropped static ICU (~22 MB/arch); Nd digit normalize uses a local shim. iOS can use `ios/prebuilt/` + `tool/prebuild_ios.sh` to skip CMake at pod install.
* **Native collisions:** iOS static stack keeps only `ephone_*` C API symbols global (`ld -r` + `ios/ephone_exports.txt`) to reduce Abseil/protobuf/RE2 clashes with other plugins.

## 0.1.0

* Supports Flutter `>=3.10.0` and Dart `>=3.0.0 <4.0.0` (no longer requires Flutter 3.24+).
* Fixed controller/focus-node ownership, `initialValue` handling, and lifecycle listener leaks in `EPhoneField`.
* Fixed phone `onChanged` crash when clearing the field and improved email/phone type detection.
* Enabled phone masking by default with a space separator.
* Rewrote phone input formatters with safer filtering, caret preservation, and deletion fixes.
* Split country data into model/data files, added North Macedonia to `Country.values`, corrected 31 mask/length mismatches, and removed 61 unused flag assets.
* Improved country picker layout, keyboard handling, search, accessibility, and theme-aware styling.
* Added `onTypeChanged`, `EphoneFieldValidators`, and widened public exports for formatters and utils.
* Renamed `CountryPickerHeigth` to `CountryPickerHeight` and `PhoneNumberDigistOnlyFormatter` to `PhoneNumberDigitsOnlyFormatter` with deprecated aliases.
* Modernized CI, added `analysis_options.yaml`, refreshed the example app, and expanded test coverage.

## 0.0.2

* Added page country picker type.
* Updated MaskSplitCharacter to be a string instead of a char.
* Split validators as emailValidator and phoneValidator.
* Fixed readme.md remote assets.
* Increased test coverage to 99%.
* Fixed Dart Version Problems
