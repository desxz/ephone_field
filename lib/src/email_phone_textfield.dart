import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/country_picker_button.dart';
import 'enums/country.dart';
import 'enums/country_picker_height.dart';
import 'enums/country_picker_menu.dart';
import 'enums/ephone_textfield_type.dart';

/// A versatile [TextFormField] for email and phone number input.
class EPhoneField extends StatefulWidget {
  /// Creates an email/phone input field.
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
    this.pickerHeight = CountryPickerHeight.h50,
    this.menuType = PickerMenuType.bottomSheet,
    this.initialCountry = Country.unitedStates,
    this.onChanged,
    this.onCountryChanged,
    this.onTypeChanged,
    this.initialValue,
    this.emptyLabelText = 'Email or phone number',
    this.emailLabelText = 'Email',
    this.phoneLabelText = 'Phone number',
    this.onSaved,
    this.onFieldSubmitted,
    this.decoration = const InputDecoration(
      border: OutlineInputBorder(),
    ),
    this.countryPickerButtonIcon = Icons.arrow_drop_down,
    this.phoneNumberMaskSplitter = ' ',
    this.inputFormatters,
    this.emailValidator,
    this.phoneValidator,
    this.emptyErrorText,
    this.countryPickerButtonWidth = 108.0,
    this.autovalidateMode,
    this.typeResolver = defaultEphoneFieldTypeResolver,
  });

  /// Focus node for the input field.
  final FocusNode? focusNode;

  /// Text editing controller for the input field.
  final TextEditingController? controller;

  /// Countries shown in the picker.
  final List<Country> countries;

  /// Initial selected country.
  final Country initialCountry;

  /// Initial field type when empty.
  final EphoneFieldType initialType;

  /// Initial text value when no [controller] is supplied.
  final String? initialValue;

  /// Optional title for the country picker.
  final String? title;

  /// Padding around the picker title.
  final EdgeInsetsGeometry titlePadding;

  /// Presentation style for the country picker.
  final PickerMenuType menuType;

  /// Decoration for the country search field.
  final InputDecoration searchInputDecoration;

  /// Height of dialog and bottom-sheet pickers.
  final CountryPickerHeight pickerHeight;

  /// Whether the country picker includes a search field.
  final bool isSearchable;

  /// Label when the field is empty.
  final String emptyLabelText;

  /// Label when the field is in email mode.
  final String emailLabelText;

  /// Label when the field is in phone mode.
  final String phoneLabelText;

  /// Called when the selected country changes.
  final ValueChanged<Country>? onCountryChanged;

  /// Called when the detected field type changes.
  final ValueChanged<EphoneFieldType>? onTypeChanged;

  /// Called when the text changes.
  final void Function(String)? onChanged;

  /// Called when the field is saved.
  final void Function(String?)? onSaved;

  /// Called when the field is submitted.
  final void Function(String?)? onFieldSubmitted;

  /// Validator for email input.
  final String? Function(String?)? emailValidator;

  /// Validator for phone input (receives full international number).
  final String? Function(String?)? phoneValidator;

  /// Error text shown when the field is empty in initial mode.
  final String? emptyErrorText;

  /// Decoration for the main input field.
  final InputDecoration decoration;

  /// Icon shown on the country picker button.
  final IconData countryPickerButtonIcon;

  /// Mask separator used while formatting phone numbers.
  final String? phoneNumberMaskSplitter;

  /// Optional custom input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Minimum width of the country picker button.
  final double countryPickerButtonWidth;

  /// Autovalidate mode for the form field.
  final AutovalidateMode? autovalidateMode;

  /// Custom resolver for email vs phone detection.
  final EphoneFieldTypeResolver typeResolver;

  @override
  State<EPhoneField> createState() => _EPhoneFieldState();
}

class _EPhoneFieldState extends State<EPhoneField> {
  late EphoneFieldType _type;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late Country _selectedCountry;
  late bool _ownsController;
  late bool _ownsFocusNode;
  late VoidCallback _controllerListener;

  List<TextInputFormatter>? _cachedFormatters;
  EphoneFieldType? _cachedFormatterType;
  Country? _cachedFormatterCountry;
  String? _cachedFormatterSplitter;

  @override
  void initState() {
    super.initState();
    _type = widget.initialType;
    _selectedCountry = widget.initialCountry;
    _bindController(widget.controller);
    _bindFocusNode(widget.focusNode);
    _controllerListener = _handleControllerChanged;
    _controller.addListener(_controllerListener);
    if (widget.controller == null && widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    _syncTypeFromText(notify: false);
  }

  @override
  void didUpdateWidget(covariant EPhoneField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_controllerListener);
      if (_ownsController) {
        _controller.dispose();
      }
      _bindController(widget.controller);
      _controller.addListener(_controllerListener);
    }

    if (widget.focusNode != oldWidget.focusNode) {
      if (_ownsFocusNode) {
        _focusNode.dispose();
      }
      _bindFocusNode(widget.focusNode);
    }

    if (widget.initialCountry != oldWidget.initialCountry) {
      _selectedCountry = widget.initialCountry;
    }

    if (widget.initialType != oldWidget.initialType &&
        _controller.text.isEmpty) {
      _type = widget.initialType;
    }
  }

  void _bindController(TextEditingController? controller) {
    _ownsController = controller == null;
    _controller = controller ?? TextEditingController();
  }

  void _bindFocusNode(FocusNode? focusNode) {
    _ownsFocusNode = focusNode == null;
    _focusNode = focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _controller.removeListener(_controllerListener);
    if (_ownsController) {
      _controller.dispose();
    }
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleControllerChanged() {
    if (!mounted) {
      return;
    }
    _syncTypeFromText();
  }

  void _syncTypeFromText({bool notify = true}) {
    final resolved = widget.typeResolver(_controller.text, widget.initialType);
    if (resolved == _type) {
      return;
    }
    if (!notify) {
      _type = resolved;
      return;
    }
    setState(() {
      _type = resolved;
    });
    widget.onTypeChanged?.call(resolved);
  }

  EphoneFieldType get _resolvedType =>
      widget.typeResolver(_controller.text, widget.initialType);

  @override
  Widget build(BuildContext context) {
    final type = _resolvedType;
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      autovalidateMode: widget.autovalidateMode,
      autofillHints: type.autofillHints,
      onChanged: (value) {
        widget
            .typeResolver(value, widget.initialType)
            .onChanged(
              _selectedCountry,
              widget.phoneNumberMaskSplitter,
              widget.onChanged,
            )
            ?.call(value);
      },
      onSaved: (value) {
        widget
            .typeResolver(value ?? '', widget.initialType)
            .onSaved(
              _selectedCountry,
              widget.phoneNumberMaskSplitter,
              widget.onSaved,
            )
            ?.call(value);
      },
      onFieldSubmitted: (value) {
        widget
            .typeResolver(value, widget.initialType)
            .onFieldSubmitted(
              _selectedCountry,
              widget.phoneNumberMaskSplitter,
              widget.onFieldSubmitted,
            )
            ?.call(value);
      },
      decoration: widget.decoration.copyWith(
        prefixIcon: _buildPrefixIcon(type),
        labelText: type.labelText(
          widget.emptyLabelText,
          widget.emailLabelText,
          widget.phoneLabelText,
        ),
      ),
      keyboardType: type.keyboardType,
      validator: type.validator(
        _validatorForType(type),
        _selectedCountry,
        widget.phoneNumberMaskSplitter,
      ),
      inputFormatters: _formattersForType(type),
    );
  }

  String? Function(String?)? _validatorForType(EphoneFieldType type) {
    switch (type) {
      case EphoneFieldType.initial:
        return widget.emptyErrorText == null
            ? null
            : (value) =>
                value == null || value.isEmpty ? widget.emptyErrorText : null;
      case EphoneFieldType.email:
        return widget.emailValidator;
      case EphoneFieldType.phone:
        return widget.phoneValidator;
    }
  }

  List<TextInputFormatter> _formattersForType(EphoneFieldType type) {
    if (widget.inputFormatters != null) {
      return widget.inputFormatters!;
    }

    final splitter = widget.phoneNumberMaskSplitter;
    if (_cachedFormatters != null &&
        _cachedFormatterType == type &&
        _cachedFormatterCountry == _selectedCountry &&
        _cachedFormatterSplitter == splitter) {
      return _cachedFormatters!;
    }

    _cachedFormatters = type.inputFormatters(_selectedCountry, splitter);
    _cachedFormatterType = type;
    _cachedFormatterCountry = _selectedCountry;
    _cachedFormatterSplitter = splitter;
    return _cachedFormatters!;
  }

  Widget? _buildPrefixIcon(EphoneFieldType type) {
    if (type != EphoneFieldType.phone) {
      return widget.decoration.prefixIcon;
    }

    final countryButton = CountryPickerButton(
      selectedCountry: _selectedCountry,
      onValuePicked: _handleCountryPicked,
      menuType: widget.menuType,
      isSearchable: widget.isSearchable,
      searchInputDecoration: widget.searchInputDecoration,
      titlePadding: widget.titlePadding,
      title: widget.title,
      countries: widget.countries,
      minWidth: widget.countryPickerButtonWidth,
      icon: widget.countryPickerButtonIcon,
      pickerHeight: widget.pickerHeight,
    );

    final userPrefix = widget.decoration.prefixIcon;
    if (userPrefix == null) {
      return countryButton;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        userPrefix,
        countryButton,
      ],
    );
  }

  void _handleCountryPicked(Country country) {
    setState(() {
      _selectedCountry = country;
      _invalidateFormatterCache();
    });
    widget.onCountryChanged?.call(country);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  void _invalidateFormatterCache() {
    _cachedFormatters = null;
    _cachedFormatterType = null;
    _cachedFormatterCountry = null;
    _cachedFormatterSplitter = null;
  }
}
