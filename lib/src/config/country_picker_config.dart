import 'package:flutter/material.dart';

import '../enums/country.dart';
import '../enums/country_picker_height.dart';
import '../enums/country_picker_menu.dart';

/// Configuration for the country picker button and menu.
class CountryPickerConfig {
  /// Creates country picker settings.
  const CountryPickerConfig({
    this.menuType = PickerMenuType.bottomSheet,
    this.pickerHeight = CountryPickerHeight.h50,
    this.isSearchable = true,
    this.searchInputDecoration,
    this.title,
    this.titlePadding = const EdgeInsets.fromLTRB(16, 8, 16, 4),
    this.buttonIcon = Icons.arrow_drop_down,
    this.buttonWidth = 108.0,
    this.countries = Country.values,
    this.useFlagImages = false,
  });

  /// How the picker is presented.
  final PickerMenuType menuType;

  /// Height preset for dialog and bottom-sheet pickers.
  final CountryPickerHeight pickerHeight;

  /// Whether the picker includes a search field.
  final bool isSearchable;

  /// Decoration for the search field; themed default when null.
  final InputDecoration? searchInputDecoration;

  /// Optional title for dialog, sheet, or page.
  final String? title;

  /// Padding around inline picker titles (bottom sheet).
  final EdgeInsetsGeometry titlePadding;

  /// Icon on the country picker button.
  final IconData buttonIcon;

  /// Minimum width of the country picker button.
  final double buttonWidth;

  /// Countries available for selection.
  final List<Country> countries;

  /// When true, load PNG flag assets (requires `assets/flags/` in the package
  /// pubspec). Defaults to false (emoji only) so consumer apps stay lean.
  final bool useFlagImages;

  /// Themed default search field decoration.
  static InputDecoration themedSearchDecoration(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(12);
    return InputDecoration(
      hintText: 'Search your country',
      isDense: true,
      filled: true,
      fillColor: scheme.surfaceContainerHighest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none),
      enabledBorder:
          OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: scheme.primary, width: 2),
      ),
      suffixIcon: Icon(Icons.search, size: 20, color: scheme.onSurfaceVariant),
    );
  }

  /// Resolves [searchInputDecoration] or the themed default.
  InputDecoration resolveSearchDecoration(BuildContext context) =>
      searchInputDecoration ?? themedSearchDecoration(context);
}
