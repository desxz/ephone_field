import 'package:flutter/widgets.dart';

/// Height presets for dialog and bottom-sheet country pickers.
enum CountryPickerHeight {
  /// Full screen height.
  h100,

  /// 75% of screen height.
  h75,

  /// 50% of screen height.
  h50,

  /// 25% of screen height.
  h25,
}

/// Extension that resolves picker heights from screen size.
extension CountryPickerHeightExtension on CountryPickerHeight {
  /// Returns the picker height for the current screen.
  double height(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    switch (this) {
      case CountryPickerHeight.h100:
        return screenHeight;
      case CountryPickerHeight.h50:
        return screenHeight / 2;
      case CountryPickerHeight.h75:
        return screenHeight * 0.75;
      case CountryPickerHeight.h25:
        return screenHeight * 0.25;
    }
  }
}

/// Deprecated alias for [CountryPickerHeight].
@Deprecated('Use CountryPickerHeight instead.')
typedef CountryPickerHeigth = CountryPickerHeight;
