import 'package:flutter/widgets.dart';

/// This enum is used to set the height of the country picker
enum CountryPickerHeigth {
  /// 100% of screen height
  h100,

  /// 75% of screen height
  h75,

  /// 50% of screen height
  h50,

  /// 25% of screen height
  h25
}

/// This extension is used to get the height of the country picker
/// based on the [CountryPickerHeigth] enum
extension CountryPickerHeigthExtension on CountryPickerHeigth {
  /// Returns the height of the country picker based on the [CountryPickerHeigth] enum
  double height(BuildContext context) {
    switch (this) {
      /// 100% of screen height
      case CountryPickerHeigth.h100:
        return MediaQuery.of(context).size.height;

      /// 75% of screen height
      case CountryPickerHeigth.h50:
        return MediaQuery.of(context).size.height / 2;

      /// 50% of screen height
      case CountryPickerHeigth.h75:
        return MediaQuery.of(context).size.height * 0.75;

      /// 25% of screen height
      case CountryPickerHeigth.h25:
        return MediaQuery.of(context).size.height * 0.25;
    }
  }
}
