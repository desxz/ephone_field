import 'package:flutter/material.dart';

import '../enums/country.dart';
import 'country_picker.dart';

/// Container for a searchable country picker list.
class CountryPickerMenu extends StatelessWidget {
  /// Creates a country picker menu.
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
    this.selectedCountry,
    this.showTitle = true,
  });

  /// Called when a country is selected.
  final void Function(Country) onValuePicked;

  /// Builder for each country row.
  final Widget Function(Country) itemBuilder;

  /// Decoration for the search field.
  final InputDecoration searchInputDecoration;

  /// Padding around the title.
  final EdgeInsetsGeometry titlePadding;

  /// Whether the search field is shown.
  final bool isSearchable;

  /// Optional title shown above the list.
  final String? title;

  /// Height of the menu when constrained by a parent.
  final double? height;

  /// Countries available for selection.
  final List<Country> countries;

  /// Currently selected country.
  final Country? selectedCountry;

  /// Whether to render the inline title.
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    final picker = CountryPicker(
      isSearchable: isSearchable,
      onValuePicked: onValuePicked,
      itemBuilder: itemBuilder,
      searchInputDecoration: searchInputDecoration,
      countries: countries,
      selectedCountry: selectedCountry,
    );

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTitle && title != null)
          Padding(
            padding: titlePadding,
            child: Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        Expanded(child: picker),
      ],
    );

    if (height == null) {
      return content;
    }

    return SizedBox(height: height, child: content);
  }
}
