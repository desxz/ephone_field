import 'package:ephone_field/ephone_field.dart';
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
  final List<Country> countries = Country.values;
  final String title = 'Select Country';
  final bool isSearchable = true;
  final double minWidth = 150;
  final EdgeInsetsGeometry titlePadding = const EdgeInsets.all(8);
  final InputDecoration searchInputDecoration = const InputDecoration(
    hintText: 'hintText',
  );
  final IconData icon = Icons.add;
  final Country initialValue = Country.afghanistan;
  final PickerMenuType menuType;
  final CountryPickerHeight pickerHeight;
  final void Function(Country) onValuePicked =
      EphoneFieldCallerChecker.mockOnValuePicked;
  BuildContext? ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          child: CountryPickerButton(
            countries: countries,
            minWidth: minWidth,
            icon: icon,
            searchInputDecoration: searchInputDecoration,
            title: title,
            isSearchable: isSearchable,
            titlePadding: titlePadding,
            onValuePicked: onValuePicked,
            initialValue: initialValue,
            menuType: menuType,
            pickerHeight: menuType == PickerMenuType.page
                ? CountryPickerHeight.h100
                : pickerHeight,
          ),
        ),
      ),
    );
  }
}
