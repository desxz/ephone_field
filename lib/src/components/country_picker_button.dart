import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enums/country.dart';
import '../enums/country_picker_height.dart';
import '../enums/country_picker_menu.dart';
import 'country_card.dart';
import 'country_picker_menu.dart';

class CountryPickerButton extends StatelessWidget {
  const CountryPickerButton({
    Key? key,
    required this.initialValue,
    required this.onValuePicked,
    required this.menuType,
    required this.isSearchable,
    required this.searchInputDecoration,
    required this.titlePadding,
    required this.title,
    required this.countries,
    required this.width,
    required this.icon,
    required this.pickerHeight,
  }) : super(key: key);

  final void Function(Country) onValuePicked;
  final Country initialValue;
  final List<Country> countries;
  final PickerMenuType menuType;
  final bool isSearchable;
  final InputDecoration searchInputDecoration;
  final EdgeInsetsGeometry titlePadding;
  final CountryPickerHeigth pickerHeight;
  final String? title;
  final double width;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openCountryPickerMenu(
          menuType, context, searchInputDecoration, title, titlePadding, pickerHeight, isSearchable, countries, onValuePicked),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '+${initialValue.dialCode}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 4.0,
              ),
              Image.asset(
                initialValue.flagImagePath,
                package: 'ephone_field',
                width: 20.0,
              ),
              const SizedBox(
                width: 4.0,
              ),
              Icon(icon),
            ],
          ),
        ),
      ),
    );
  }
}

void Function()? _openCountryPickerMenu(
    PickerMenuType menuType,
    BuildContext context,
    InputDecoration searchInputDecoration,
    String? title,
    EdgeInsetsGeometry titlePadding,
    CountryPickerHeigth pickerHeight,
    bool isSearchable,
    List<Country> countries,
    void Function(Country) onValuePicked) {
  switch (menuType) {
    case PickerMenuType.dialog:
      return _openCountryPickerDialog(
          context, searchInputDecoration, title, titlePadding, isSearchable, pickerHeight, countries, onValuePicked);
    case PickerMenuType.bottomSheet:
      return _openCountryPickerBottomSheet(
          context, searchInputDecoration, title, titlePadding, isSearchable, pickerHeight, countries, onValuePicked);

    case PickerMenuType.screen:
      return _openCountryPickerScreen(
          context, searchInputDecoration, title, titlePadding, isSearchable, pickerHeight, countries, onValuePicked);
    default:
      return null;
  }
}

void Function()? _openCountryPickerScreen(
    BuildContext context,
    InputDecoration searchInputDecoration,
    String? title,
    EdgeInsetsGeometry titlePadding,
    bool isSearchable,
    CountryPickerHeigth pickerHeight,
    List<Country> countries,
    void Function(Country) onValuePicked) {
  return () {
    final _pageBody = Material(
      child: SafeArea(
        child: CountryPickerMenu(
          title: title,
          titlePadding: titlePadding,
          isSearchable: isSearchable,
          height: MediaQuery.of(context).size.height,
          searchInputDecoration: searchInputDecoration,
          onValuePicked: (Country country) => onValuePicked(country),
          itemBuilder: (Country country) => CountryCard(country: country),
          countries: countries,
        ),
      ),
    );
    /// Navigate to the screen depending on the platform type
    if (Platform.isIOS) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              brightness: Brightness.dark,
              middle: Text(title ?? ''),
              previousPageTitle: 'Back',
            ),
            child: _pageBody,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text(title ?? '')),
            body: _pageBody,
          ),
        ),
      );
    }
  };
}

void Function()? _openCountryPickerDialog(
    BuildContext context,
    InputDecoration searchInputDecoration,
    String? title,
    EdgeInsetsGeometry titlePadding,
    bool isSearchable,
    CountryPickerHeigth pickerHeight,
    List<Country> countries,
    void Function(Country) onValuePicked) {
  return () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: titlePadding,
        content: SizedBox(
          height: pickerHeight.height(context),
          width: MediaQuery.of(context).size.width * 0.8,
          child: CountryPickerMenu(
            title: title,
            titlePadding: titlePadding,
            isSearchable: isSearchable,
            height: pickerHeight.height(context),
            searchInputDecoration: searchInputDecoration,
            onValuePicked: (Country country) {
              return onValuePicked(country);
            },
            itemBuilder: (Country country) {
              return CountryCard(country: country);
            },
            countries: countries,
          ),
        ),
      ),
    );
  };
}

void Function()? _openCountryPickerBottomSheet(
  BuildContext context,
  InputDecoration searchInputDecoration,
  String? title,
  EdgeInsetsGeometry titlePadding,
  bool isSearchable,
  CountryPickerHeigth pickerHeight,
  List<Country> countries,
  void Function(Country) onValuePicked,
) {
  return () {
    showModalBottomSheet(
      context: context,
      shape: pickerHeight != CountryPickerHeigth.h100
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            )
          : null,
      isScrollControlled: true,
      builder: (context) => CountryPickerMenu(
        title: title,
        titlePadding: titlePadding,
        isSearchable: isSearchable,
        height: pickerHeight.height(context),
        searchInputDecoration: searchInputDecoration,
        onValuePicked: (Country country) {
          return onValuePicked(country);
        },
        itemBuilder: (Country country) {
          return CountryCard(country: country);
        },
        countries: countries,
      ),
    );
  };
}
