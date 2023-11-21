import 'package:ephone_field/ephone_field.dart';
import 'package:ephone_field/src/components/components.dart';
import 'package:flutter/material.dart';

class CountryPickerMock extends StatelessWidget {
  CountryPickerMock({Key? key, required this.onValuePicked}) : super(key: key);

  final List<Country> countries = Country.values;
  final bool isSearchable = true;
  final InputDecoration searchInputDecoration = const InputDecoration(
    hintText: 'hintText',
  );
  // ignore: prefer_function_declarations_over_variables
  final Widget Function(Country) itemBuilder =
      (Country c) => CountryCard(country: c);
  // ignore: prefer_function_declarations_over_variables
  final dynamic Function(Country) onValuePicked;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CountryPicker(
            onValuePicked: onValuePicked,
            itemBuilder: itemBuilder,
            searchInputDecoration: searchInputDecoration,
            isSearchable: isSearchable,
            countries: countries),
      ),
    );
  }
}
