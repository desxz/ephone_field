import 'package:flutter/material.dart';

import '../enums/country.dart';

/// Searchable list of countries.
class CountryPicker extends StatefulWidget {
  /// Creates a country picker.
  const CountryPicker({
    super.key,
    required this.onValuePicked,
    required this.itemBuilder,
    required this.searchInputDecoration,
    required this.isSearchable,
    required this.countries,
    this.selectedCountry,
    this.emptyResultsText = 'No countries found',
  });

  /// Called when a country is selected.
  final void Function(Country) onValuePicked;

  /// Builder for each country row.
  final Widget Function(Country) itemBuilder;

  /// Decoration for the search field.
  final InputDecoration searchInputDecoration;

  /// Whether the search field is shown.
  final bool isSearchable;

  /// Countries available for selection.
  final List<Country> countries;

  /// Currently selected country.
  final Country? selectedCountry;

  /// Message shown when search returns no results.
  final String emptyResultsText;

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  late List<Country> _filteredCountries;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isClosing = false;

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _controller.addListener(_handleSearchChanged);
  }

  @override
  void didUpdateWidget(covariant CountryPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.countries != oldWidget.countries && _controller.text.isEmpty) {
      _filteredCountries = widget.countries;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleSearchChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSearchChanged() {
    final text = _normalize(_controller.text);
    if (text.isEmpty) {
      setState(() {
        _filteredCountries = widget.countries;
      });
      return;
    }

    setState(() {
      _filteredCountries =
          widget.countries.where((country) {
            return _normalize(country.alpha2).contains(text) ||
                _normalize(country.alpha3).contains(text) ||
                _normalize(country.name).contains(text) ||
                country.dialCode.toString().contains(text);
          }).toList();
    });
  }

  String _normalize(String value) {
    const accents = {
      'á': 'a',
      'à': 'a',
      'ä': 'a',
      'â': 'a',
      'ã': 'a',
      'é': 'e',
      'è': 'e',
      'ë': 'e',
      'ê': 'e',
      'í': 'i',
      'ì': 'i',
      'ï': 'i',
      'î': 'i',
      'ó': 'o',
      'ò': 'o',
      'ö': 'o',
      'ô': 'o',
      'õ': 'o',
      'ú': 'u',
      'ù': 'u',
      'ü': 'u',
      'û': 'u',
      'ç': 'c',
      'ñ': 'n',
    };

    final lower = value.toLowerCase();
    final buffer = StringBuffer();
    for (var i = 0; i < lower.length; i++) {
      final char = lower[i];
      buffer.write(accents[char] ?? char);
    }
    return buffer.toString();
  }

  void _handleCountryTap(Country country) {
    if (_isClosing || !mounted) {
      return;
    }
    _isClosing = true;
    widget.onValuePicked(country);
    Navigator.of(context).pop();
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: TextField(
        key: const Key('search-field'),
        focusNode: _focusNode,
        controller: _controller,
        textInputAction: TextInputAction.search,
        decoration: widget.searchInputDecoration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isSearchable) _buildSearchField(),
        Expanded(
          child:
              _filteredCountries.isEmpty
                  ? Center(
                    child: Text(
                      widget.emptyResultsText,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                  : ListView.builder(
                    key: const Key('country-picker-list'),
                    itemCount: _filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = _filteredCountries[index];
                      return InkWell(
                        onTap: () => _handleCountryTap(country),
                        child: widget.itemBuilder(country),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
