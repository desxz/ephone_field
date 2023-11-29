import 'package:flutter/widgets.dart';

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

// This extension is used to get the height of the CountryPicker based on the CountryPickerHeigth enum
// Example: CountryPickerHeigth.h100.height(context) will return the height of the CountryPicker based on the screen height
extension CountryPickerHeigthExtension on CountryPickerHeigth {
  /// Returns the height of the CountryPicker based on the CountryPickerHeigth enum
  double height(BuildContext context) {
    switch (this) {
      // 100% of screen height
      case CountryPickerHeigth.h100:
        return MediaQuery.of(context).size.height;
      // 75% of screen height
      case CountryPickerHeigth.h50:
        return MediaQuery.of(context).size.height / 2;
      // 50% of screen height
      case CountryPickerHeigth.h75:
        return MediaQuery.of(context).size.height * 0.75;
      // 25% of screen height
      case CountryPickerHeigth.h25:
        return MediaQuery.of(context).size.height * 0.25;
    }
  }
}
