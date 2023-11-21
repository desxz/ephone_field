import 'package:ephone_field/src/components/country_picker_button.dart';
import 'package:ephone_field/src/enums/country.dart';
import 'package:ephone_field/src/enums/country_picker_height.dart';
import 'package:ephone_field/src/enums/country_picker_menu.dart';
import 'package:ephone_field/src/enums/ephone_textfield_type.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CountryPickerButtonMock extends StatelessWidget {
  CountryPickerButtonMock(
      {Key? key, required this.menuType, required this.pickerHeight, this.ctx})
      : super(key: key);
  final List<Country> countries = Country.values;
  final String title = "Select Country";
  final bool isSearchable = true;
  final double width = 150.0;
  final EdgeInsetsGeometry titlePadding = const EdgeInsets.all(8.0);
  final InputDecoration searchInputDecoration = const InputDecoration(
    hintText: 'hintText',
  );
  final IconData icon = Icons.add;
  final Country initialValue = Country.afghanistan;
  final EphoneFieldType initialType = EphoneFieldType.phone;
  final PickerMenuType menuType;
  final CountryPickerHeigth pickerHeight;
  BuildContext? ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          child: CountryPickerButton(
            countries: countries,
            width: width,
            icon: icon,
            searchInputDecoration: searchInputDecoration,
            title: title,
            isSearchable: isSearchable,
            titlePadding: titlePadding,
            onValuePicked: (Country c) {},
            initialValue: initialValue,
            menuType: menuType,
            pickerHeight: menuType == PickerMenuType.page
                ? CountryPickerHeigth.h100
                : pickerHeight,
          ),
        ),
      ),
    );
  }
}
