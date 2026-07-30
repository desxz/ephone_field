import 'package:ephone_field/ephone_field.dart';
import 'package:ephone_field/src/components/country_picker_button.dart';
import 'package:flutter/material.dart';

import '../utils/caller_checker.dart';

// ignore: must_be_immutable
class CountryPickerButtonMock extends StatelessWidget {
  CountryPickerButtonMock({
    super.key,
    required this.menuType,
    required this.pickerHeight,
    this.ctx,
  });

  final Country initialValue = Country.afghanistan;
  final PickerMenuType menuType;
  final CountryPickerHeight pickerHeight;
  final void Function(Country) onValuePicked =
      EphoneFieldCallerChecker.mockOnValuePicked;
  BuildContext? ctx;

  CountryPickerConfig get _config => CountryPickerConfig(
        menuType: menuType,
        pickerHeight: menuType == PickerMenuType.page
            ? CountryPickerHeight.h100
            : pickerHeight,
        title: 'Select Country',
        isSearchable: true,
        buttonWidth: 150,
        buttonIcon: Icons.add,
        searchInputDecoration: const InputDecoration(hintText: 'hintText'),
      );

  IconData get icon => _config.buttonIcon;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return MaterialApp(
      home: Scaffold(
        body: CountryPickerButton(
          selectedCountry: initialValue,
          onValuePicked: onValuePicked,
          config: _config,
        ),
      ),
    );
  }
}
