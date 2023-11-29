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

extension CountryPickerHeigthExtension on CountryPickerHeigth {
  double height(BuildContext context) {
    switch (this) {
      case CountryPickerHeigth.h100:
        return MediaQuery.of(context).size.height;
      case CountryPickerHeigth.h50:
        return MediaQuery.of(context).size.height / 2;
      case CountryPickerHeigth.h75:
        return MediaQuery.of(context).size.height * 0.75;
      case CountryPickerHeigth.h25:
        return MediaQuery.of(context).size.height * 0.25;
      default:
        return MediaQuery.of(context).size.height;
    }
  }
}
