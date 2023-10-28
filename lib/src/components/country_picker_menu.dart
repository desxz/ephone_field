import 'package:flutter/material.dart';

import '../enums/country.dart';
import 'country_picker.dart';

class CountryPickerMenu extends StatelessWidget {
  const CountryPickerMenu({
    super.key,
    required this.onValuePicked,
    required this.itemBuilder,
    required this.titlePadding,
    required this.isSearchable,
    required this.title,
    required this.searchInputDecoration,
    required this.height,
    required this.countries,
  });
  final Function(Country) onValuePicked;
  final Widget Function(Country) itemBuilder;
  final InputDecoration searchInputDecoration;
  final EdgeInsetsGeometry titlePadding;
  final bool isSearchable;
  final String? title;
  final double height;
  final List<Country> countries;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (title != null)
            Padding(
              padding: titlePadding,
              child: Text(
                title!,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Expanded(
            child: CountryPicker(
              isSearchable: isSearchable,
              onValuePicked: onValuePicked,
              itemBuilder: itemBuilder,
              searchInputDecoration: searchInputDecoration,
              countries: countries,
            ),
          ),
        ],
      ),
    );
  }
}
