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
