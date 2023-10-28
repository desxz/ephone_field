import 'package:ephone_field/src/components/country_card.dart';
import 'package:ephone_field/src/components/country_picker_menu.dart';
import 'package:ephone_field/src/enums/country.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CountryPickerMenuMock extends StatelessWidget {
  CountryPickerMenuMock({
    super.key,
  });
  final List<Country> countries = Country.values;
  final String title = 'title';
  final bool isSearchable = true;
  final double height = 500.0;
  final EdgeInsetsGeometry titlePadding = const EdgeInsets.all(8.0);
  final InputDecoration searchInputDecoration = const InputDecoration(
    hintText: 'hintText',
  );
  // ignore: prefer_function_declarations_over_variables
  final Widget Function(Country) itemBuilder =
      (Country c) => CountryCard(country: c);
  // ignore: prefer_function_declarations_over_variables
  final void Function(Country) onValuePicked = (Country c) {
    if (kDebugMode) {
      print(c.name);
    }
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          child: CountryPickerMenu(
            countries: countries,
            height: height,
            searchInputDecoration: searchInputDecoration,
            title: title,
            isSearchable: isSearchable,
            titlePadding: titlePadding,
            itemBuilder: itemBuilder,
            onValuePicked: onValuePicked,
          ),
        ),
      ),
    );
  }
}
