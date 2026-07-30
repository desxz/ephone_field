import 'package:flutter/material.dart';

import '../config/country_picker_config.dart';
import '../enums/country.dart';
import '../enums/country_picker_height.dart';
import '../enums/country_picker_menu.dart';
import 'country_card.dart';
import 'country_flag.dart';
import 'country_picker_menu.dart';

/// Button that opens the country picker.
class CountryPickerButton extends StatefulWidget {
  /// Creates a country picker button.
  const CountryPickerButton({
    super.key,
    required this.selectedCountry,
    required this.onValuePicked,
    this.config = const CountryPickerConfig(),
    this.enabled = true,
  });

  /// Called when a country is selected.
  final void Function(Country) onValuePicked;

  /// Currently selected country.
  final Country selectedCountry;

  /// Picker presentation and list settings.
  final CountryPickerConfig config;

  /// Whether the picker can be opened.
  final bool enabled;

  @override
  State<CountryPickerButton> createState() => _CountryPickerButtonState();
}

class _CountryPickerButtonState extends State<CountryPickerButton> {
  bool _isMenuOpen = false;

  CountryPickerConfig get _config => widget.config;

  Future<void> _openPicker() async {
    if (!widget.enabled || _isMenuOpen || !mounted) {
      return;
    }
    setState(() {
      _isMenuOpen = true;
    });

    try {
      switch (_config.menuType) {
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
      useFlagImages: _config.useFlagImages,
    );
  }

  CountryPickerMenu _buildMenu({
    required double? height,
    required bool showTitle,
    String? title,
    required BuildContext context,
  }) {
    return CountryPickerMenu(
      title: title,
      showTitle: showTitle,
      titlePadding: _config.titlePadding,
      isSearchable: _config.isSearchable,
      height: height,
      searchInputDecoration: _config.resolveSearchDecoration(context),
      onValuePicked: widget.onValuePicked,
      itemBuilder: _countryCard,
      countries: _config.countries,
      selectedCountry: widget.selectedCountry,
    );
  }

  Future<void> _openDialog() async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final pickerHeight = _config.pickerHeight.height(dialogContext);

        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: double.maxFinite,
            height: pickerHeight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_config.title != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        _config.title!,
                        style: Theme.of(dialogContext)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                Expanded(
                  child: _buildMenu(
                    // Parent [Expanded] already bounds height; a nested
                    // SizedBox(height: pickerHeight) would overflow when a
                    // title consumes vertical space above.
                    height: null,
                    showTitle: false,
                    context: dialogContext,
                  ),
                ),
              ],
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
      shape: _config.pickerHeight != CountryPickerHeight.h100
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            )
          : null,
      builder: (sheetContext) {
        final viewInsets = MediaQuery.viewInsetsOf(sheetContext);
        final availableHeight =
            MediaQuery.sizeOf(sheetContext).height - viewInsets.bottom;
        final height = _config.pickerHeight
            .height(sheetContext)
            .clamp(0.0, availableHeight);

        return Padding(
          padding: EdgeInsets.only(bottom: viewInsets.bottom),
          child: _buildMenu(
            height: height,
            showTitle: _config.title != null,
            title: _config.title,
            context: sheetContext,
          ),
        );
      },
    );
  }

  Future<void> _openPage() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (pageContext) {
          return Scaffold(
            appBar: _config.title == null
                ? AppBar()
                : AppBar(title: Text(_config.title!)),
            body: _buildMenu(
              height: null,
              showTitle: false,
              context: pageContext,
            ),
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
      enabled: widget.enabled,
      label: 'Select country, current +${widget.selectedCountry.dialCode}',
      child: Tooltip(
        message: 'Select country',
        child: InkWell(
          onTap: widget.enabled ? _openPicker : null,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: _config.buttonWidth),
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
                  CountryFlag(
                    country: widget.selectedCountry,
                    useImage: _config.useFlagImages,
                  ),
                  const SizedBox(width: 4),
                  Icon(_config.buttonIcon, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
