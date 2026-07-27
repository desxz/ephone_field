import 'package:flutter/material.dart';

import '../enums/country.dart';
import '../enums/country_picker_height.dart';
import '../enums/country_picker_menu.dart';
import 'country_card.dart';
import 'country_flag.dart';
import 'country_picker_menu.dart';

/// Button that opens the country picker.
class CountryPickerButton extends StatefulWidget {
  /// Creates a country picker button.
  CountryPickerButton({
    super.key,
    Country? selectedCountry,
    @Deprecated('Use selectedCountry instead.') Country? initialValue,
    required this.onValuePicked,
    required this.menuType,
    required this.isSearchable,
    required this.searchInputDecoration,
    required this.titlePadding,
    required this.title,
    required this.countries,
    required this.minWidth,
    required this.icon,
    required this.pickerHeight,
  }) : selectedCountry =
            selectedCountry ?? initialValue ?? Country.unitedStates;

  /// Called when a country is selected.
  final void Function(Country) onValuePicked;

  /// Currently selected country.
  final Country selectedCountry;

  /// Countries available in the picker.
  final List<Country> countries;

  /// Presentation style for the picker.
  final PickerMenuType menuType;

  /// Whether the picker includes search.
  final bool isSearchable;

  /// Decoration for the search field.
  final InputDecoration searchInputDecoration;

  /// Padding around the picker title.
  final EdgeInsetsGeometry titlePadding;

  /// Height preset for dialog and bottom-sheet pickers.
  final CountryPickerHeight pickerHeight;

  /// Optional picker title.
  final String? title;

  /// Minimum width of the button.
  final double minWidth;

  /// Dropdown icon.
  final IconData icon;

  @override
  State<CountryPickerButton> createState() => _CountryPickerButtonState();
}

class _CountryPickerButtonState extends State<CountryPickerButton> {
  bool _isMenuOpen = false;

  Future<void> _openPicker() async {
    if (_isMenuOpen || !mounted) {
      return;
    }
    setState(() {
      _isMenuOpen = true;
    });

    try {
      switch (widget.menuType) {
        case PickerMenuType.dialog:
          await _openDialog();
        case PickerMenuType.bottomSheet:
          await _openBottomSheet();
        case PickerMenuType.page:
          await _openPage();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isMenuOpen = false;
        });
      }
    }
  }

  Widget _countryCard(Country country) {
    return CountryCard(
      country: country,
      isSelected: country == widget.selectedCountry,
    );
  }

  CountryPickerMenu _buildMenu({
    required double? height,
    required bool showTitle,
    String? title,
  }) {
    return CountryPickerMenu(
      title: title,
      showTitle: showTitle,
      titlePadding: widget.titlePadding,
      isSearchable: widget.isSearchable,
      height: height,
      searchInputDecoration: widget.searchInputDecoration,
      onValuePicked: widget.onValuePicked,
      itemBuilder: _countryCard,
      countries: widget.countries,
      selectedCountry: widget.selectedCountry,
    );
  }

  Future<void> _openDialog() async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          title: widget.title == null ? null : Text(widget.title!),
          titlePadding: widget.titlePadding,
          content: SizedBox(
            height: widget.pickerHeight.height(dialogContext),
            width: MediaQuery.sizeOf(dialogContext).width * 0.85,
            child: _buildMenu(
              height: widget.pickerHeight.height(dialogContext),
              showTitle: false,
            ),
          ),
        );
      },
    );
  }

  Future<void> _openBottomSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      shape: widget.pickerHeight != CountryPickerHeight.h100
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            )
          : null,
      builder: (sheetContext) {
        final viewInsets = MediaQuery.viewInsetsOf(sheetContext);
        final availableHeight = MediaQuery.sizeOf(sheetContext).height -
            viewInsets.bottom -
            MediaQuery.paddingOf(sheetContext).top;
        final height = widget.pickerHeight.height(sheetContext).clamp(
              0.0,
              availableHeight,
            );

        return Padding(
          padding: EdgeInsets.only(bottom: viewInsets.bottom),
          child: _buildMenu(height: height, showTitle: widget.title != null),
        );
      },
    );
  }

  Future<void> _openPage() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (pageContext) {
          return Scaffold(
            appBar: widget.title == null
                ? AppBar()
                : AppBar(title: Text(widget.title!)),
            body: _buildMenu(height: null, showTitle: false),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dialStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
    );

    return Semantics(
      button: true,
      label: 'Select country, current +${widget.selectedCountry.dialCode}',
      child: Tooltip(
        message: 'Select country',
        child: InkWell(
          onTap: _openPicker,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: widget.minWidth),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        '+${widget.selectedCountry.dialCode}',
                        style: dialStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  CountryFlag(country: widget.selectedCountry),
                  const SizedBox(width: 4),
                  Icon(widget.icon, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
