import 'package:flutter/material.dart';

import '../enums/country.dart';

class CountryPicker extends StatefulWidget {
  const CountryPicker({
    Key? key,
    required this.onValuePicked,
    required this.itemBuilder,
    required this.searchInputDecoration,
    required this.isSearchable,
    required this.countries,
  }) : super(key: key);
  final Function(Country) onValuePicked;
  final Widget Function(Country) itemBuilder;
  final InputDecoration searchInputDecoration;
  final bool isSearchable;
  final List<Country> countries;

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  late List<Country> _filteredCountries;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _controller.addListener(() {
      final text = _controller.text;
      if (text.isEmpty) {
        setState(() {
          _filteredCountries = widget.countries;
        });
      } else {
        setState(() {
          _filteredCountries = widget.countries
              .where((country) =>
                  country.alpha2.toLowerCase().contains(text.toLowerCase()) ||
                  country.name.toLowerCase().contains(text.toLowerCase()) ||
                  country.dialCode
                      .toString()
                      .toLowerCase()
                      .contains(text.toLowerCase()))
              .toList();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        focusNode: _focusNode,
        controller: _controller,
        decoration: widget.searchInputDecoration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (widget.isSearchable) _buildSearchField(),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredCountries.length,
            itemBuilder: (context, index) {
              final country = _filteredCountries[index];
              return InkWell(
                onTap: () {
                  widget.onValuePicked(country);
                  Navigator.pop(context);
                },
                child: widget.itemBuilder(country),
              );
            },
          ),
        ),
      ],
    );
  }
}
