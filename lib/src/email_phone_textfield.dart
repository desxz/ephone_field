import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/country_picker_button.dart';
import 'enums/country.dart';
import 'enums/country_picker_height.dart';
import 'enums/country_picker_menu.dart';
import 'enums/ephone_textfield_type.dart';
import 'enums/mask_split_character.dart';

class EPhoneField extends StatefulWidget {
  const EPhoneField({
    super.key,
    this.controller,
    this.focusNode,
    this.initialType = EphoneFieldType.initial,
    this.countries = Country.values,
    this.searchInputDecoration = const InputDecoration(
      hintText: 'Search your country',
      border: OutlineInputBorder(),
      suffixIcon: Icon(Icons.search),
    ),
    this.isSearchable = true,
    this.title,
    this.titlePadding = const EdgeInsets.all(8.0),
    this.pickerHeight = CountryPickerHeigth.h50,
    this.menuType = PickerMenuType.bottomSheet,
    this.initialCountry = Country.unitedStates,
    this.onChanged,
    this.onCountryChanged,
    this.initialValue,
    this.emptyLabelText = 'Email or phone number',
    this.emailLabelText = 'Email',
    this.phoneLabelText = 'Phone number',
    this.onSaved,
    this.onFieldSubmitted,
    this.decoration = const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Email or phone number',
    ),
    this.countryPickerButtonIcon = Icons.arrow_drop_down,
    this.phoneNumberMaskSplitter = MaskSplitCharacter.space,
    this.inputFormatters,
    this.validator,
    this.countryPickerButtonWidth = 100.0,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  /// The [FocusNode] of the input field.
  final FocusNode? focusNode;

  /// The [TextEditingController] of the input field.
  final TextEditingController? controller;

  /// The [List<Country>] to be used in the country picker. Defaults to [Country.values].
  final List<Country> countries;

  /// The [Country] to be selected when the widget is initialized. Defaults to [Country.unitedStates].
  final Country initialCountry;

  /// The [EphoneFieldType] to be selected when the widget is initialized. Defaults to [EphoneFieldType.initial].
  final EphoneFieldType initialType;

  /// The [String] to be used as the initial value of the input field.
  final String? initialValue;

  /// The [String] to be used as title of the country picker menu.
  final String? title;

  /// The [EdgeInsetsGeometry] to be used as padding of the title of the country picker menu. Defaults to [EdgeInsets.all(8.0)].
  final EdgeInsetsGeometry titlePadding;

  /// The [PickerMenuType] to be used as the type of the country picker menu. Defaults to [PickerMenuType.bottomSheet].
  final PickerMenuType menuType;

  /// The [InputDecoration] to be used as the decoration of the search field of the country picker menu. Defaults to:
  /// ```
  /// InputDecoration(
  ///  hintText: 'Search your country',
  /// border: OutlineInputBorder(),
  /// suffixIcon: Icon(Icons.search),
  /// )
  /// ```
  final InputDecoration searchInputDecoration;

  /// The [CountryPickerHeigth] to be used as the height of the country picker menu. Defaults to [CountryPickerHeigth.half].
  final CountryPickerHeigth pickerHeight;

  /// The [bool] to be used as the searchable property of the country picker menu to visible or hide the search field. Defaults to [true].
  final bool isSearchable;

  /// The [String] to be used as the empty label text of the input field. Defaults to 'Email or phone number'.
  final String emptyLabelText;

  /// The [String] to be used as the email label text of the input field. Defaults to 'Email'.
  final String emailLabelText;

  /// The [String] to be used as the phone label text of the input field. Defaults to 'Phone number'.
  final String phoneLabelText;

  /// The [ValueChanged<Country>] to be used as the callback when the country is changed.
  final ValueChanged<Country>? onCountryChanged;

  /// The [ValueChanged<String>] to be used as the callback when the value of the input field is changed.
  final void Function(String)? onChanged;

  /// The [ValueChanged<String>] to be used as the callback when the value of the input field is saved.
  final void Function(String?)? onSaved;

  /// The [ValueChanged<String>] to be used as the callback when the value of the input field is submitted.
  final void Function(String?)? onFieldSubmitted;

  /// The [String? Function(String?)] to be used as the validator of the input field.
  final String? Function(String?)? validator;

  /// The [InputDecoration] to be used as the decoration of the input field. Defaults to:
  /// ```
  /// InputDecoration(
  /// border: OutlineInputBorder(),
  /// hintText: 'Phone number or email',
  /// )
  /// ```
  /// The [prefixIcon] of the input field is replaced by the country picker button when the [EphoneFieldType] is [EphoneFieldType.phone].
  /// The [labelText] of the input field is replaced by the [EphoneFieldType] label text when the [EphoneFieldType] is [EphoneFieldType.phone] or [EphoneFieldType.email].
  /// The [labelText] of the input field is replaced by the [emptyLabelText] when the [EphoneFieldType] is [EphoneFieldType.initial].
  /// The [labelText] of the input field is replaced by the [emailLabelText] when the [EphoneFieldType] is [EphoneFieldType.email].
  /// The [labelText] of the input field is replaced by the [phoneLabelText] when the [EphoneFieldType] is [EphoneFieldType.phone].
  final InputDecoration decoration;

  /// The [IconData] to be used as the icon of the country picker button. Defaults to [Icons.arrow_drop_down
  final IconData countryPickerButtonIcon;

  /// The [MaskSplitCharacter] to be used as the mask splitter of the phone number input field. Defaults to [MaskSplitCharacter.space].
  /// The [MaskSplitCharacter] is only used when the [EphoneFieldType] is [EphoneFieldType.phone].
  /// If the [MaskSplitCharacter] is [MaskSplitCharacter.none], the [PhoneNumberMaskFormatter] is not used.
  /// If the [MaskSplitCharacter] is [MaskSplitCharacter.space], the [PhoneNumberMaskFormatter] is used with the space character as the mask splitter.
  /// If the [MaskSplitCharacter] is [MaskSplitCharacter.dash], the [PhoneNumberMaskFormatter] is used with the dash character as the mask splitter.
  final MaskSplitCharacter phoneNumberMaskSplitter;

  /// The [List<TextInputFormatter>] to be used as the input formatters of the input field.
  /// As default, the [PhoneNumberMaskFormatter] and [PhoneNumberDigistOnlyFormatter] are used when the [EphoneFieldType] is [EphoneFieldType.phone].
  /// If the [phoneNumberMaskSplitter] is [MaskSplitCharacter.none], the [PhoneNumberMaskFormatter] is not used.
  /// If don't want to use the [PhoneNumberMaskFormatter], you can pass an empty list to the [inputFormatters].
  final List<TextInputFormatter>? inputFormatters;

  /// The [double] to be used as the width of the country picker button. Defaults to 100.0.
  final double countryPickerButtonWidth;

  /// The [AutovalidateMode] to be used as the autovalidate mode of the input field. Defaults to [AutovalidateMode.onUserInteraction].
  final AutovalidateMode autovalidateMode;

  @override
  State<EPhoneField> createState() => _EphoneFieldState();
}

class _EphoneFieldState extends State<EPhoneField> {
  late EphoneFieldType _type;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _type = widget.initialType;
    _selectedCountry = widget.initialCountry;
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(() => _updateTextFieldType());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      autovalidateMode: widget.autovalidateMode,
      onChanged: (String value) {
        if (_type == EphoneFieldType.phone) {
          value =
              '+${_selectedCountry.dialCode}${value.replaceAll(widget.phoneNumberMaskSplitter.maskSplitCharacter, '')}';
        }
        widget.onChanged?.call(value);
      },
      onSaved: (String? value) {
        if (_type == EphoneFieldType.phone) {
          value =
              '+${_selectedCountry.dialCode}${value?.replaceAll(widget.phoneNumberMaskSplitter.maskSplitCharacter, '')}';
        }
        widget.onSaved?.call(value);
      },
      onFieldSubmitted: (String? value) {
        if (_type == EphoneFieldType.phone) {
          value =
              '+${_selectedCountry.dialCode}${value?.replaceAll(widget.phoneNumberMaskSplitter.maskSplitCharacter, '')}';
        }
        widget.onFieldSubmitted?.call(value);
      },
      initialValue: widget.initialValue,
      decoration: widget.decoration.copyWith(
          prefixIcon: _buildCountryPicker(_type == EphoneFieldType.phone),
          labelText: _type.labelText(widget.emptyLabelText,
              widget.emailLabelText, widget.phoneLabelText)),
      keyboardType: _type.keyboardType,
      validator: (String? value) {
        if (_type == EphoneFieldType.phone) {
          value =
              '+${_selectedCountry.dialCode}${value?.replaceAll(widget.phoneNumberMaskSplitter.maskSplitCharacter, '')}';
        }
        return widget.validator?.call(value);
      },
      inputFormatters: widget.inputFormatters ??
          _type.inputFormatters(
              _selectedCountry,
              widget.phoneNumberMaskSplitter != MaskSplitCharacter.none,
              widget.phoneNumberMaskSplitter.maskSplitCharacter),
    );
  }

  /// Builds the [CountryPickerButton] if the [_type] is [EphoneFieldType.phone].
  Widget? _buildCountryPicker(bool isPhoneFieldSelected) {
    return isPhoneFieldSelected
        ? CountryPickerButton(
            initialValue: _selectedCountry,
            onValuePicked: (Country country) {
              setState(() {
                _selectedCountry = country;
                widget.onCountryChanged?.call(country);
                _focusNode.requestFocus();
              });
            },
            menuType: widget.menuType,
            isSearchable: widget.isSearchable,
            searchInputDecoration: widget.searchInputDecoration,
            titlePadding: widget.titlePadding,
            title: widget.title,
            countries: widget.countries,
            width: widget.countryPickerButtonWidth,
            icon: widget.countryPickerButtonIcon,
            pickerHeight: widget.pickerHeight,
          )
        : null;
  }

  /// Updates the [_type] of the input field based on the [_controller] text.
  void _updateTextFieldType() {
    final text = _controller.text
        .replaceAll(widget.phoneNumberMaskSplitter.maskSplitCharacter, '');
    if (text.isEmpty) {
      setState(() {
        _type = widget.initialType;
      });
    } else if (text.contains('@') || int.tryParse(text) == null) {
      setState(() {
        _type = EphoneFieldType.email;
      });
    } else {
      setState(() {
        _type = EphoneFieldType.phone;
      });
    }
  }
}
