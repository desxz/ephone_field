import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'application/phone/phone_output_mapper.dart';
import 'components/country_picker_button.dart';
import 'domain/phone/phone_number_service.dart';
import 'enums/country.dart';
import 'enums/country_picker_height.dart';
import 'enums/country_picker_menu.dart';
import 'enums/ephone_textfield_type.dart';
import 'formatters/formatters.dart';
import 'infrastructure/phone/phone_number_service_factory.dart';
import 'infrastructure/phone/stub/unsupported_phone_number_service.dart';
import 'validation/field_validation_policy.dart';
import 'validation/field_validation_strategy.dart';
import 'validation/validation_binding.dart';

/// A versatile [TextFormField] for email and phone number input.
class EPhoneField extends StatefulWidget {
  /// Creates an email/phone input field.
  ///
  /// When [emailValidator] / [phoneValidator] are omitted, package defaults
  /// run. Pass a custom validator to override, or use [Validators.compose] to
  /// combine package rules with extra conditions:
  ///
  /// ```dart
  /// phoneValidator: Validators.compose([
  ///   PhoneValidators.phone,
  ///   (value) => value == '05554445544' ? 'Not allowed' : null,
  /// ]),
  /// ```
  ///
  /// Pass `(value) => null` to disable validation for that mode.
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
    this.useLibPhoneFormatting = true,
    @visibleForTesting this.debugPhoneNumberService,
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

  /// Mask separator used while formatting phone numbers (legacy mask path).
  final String? phoneNumberMaskSplitter;

  /// Optional custom input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Minimum width of the country picker button.
  final double countryPickerButtonWidth;

  /// Autovalidate mode for the form field.
  final AutovalidateMode? autovalidateMode;

  /// Custom resolver for email vs phone detection.
  final EphoneFieldTypeResolver typeResolver;

  /// When true and a native-capable service is available, use AsYouType.
  ///
  /// Falls back to the legacy mask formatter when the service is unsupported.
  final bool useLibPhoneFormatting;

  /// Test-only phone capability override. Not part of the public plugin API.
  @visibleForTesting
  final PhoneNumberService? debugPhoneNumberService;

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
  late PhoneNumberService _phoneService;
  late PhoneOutputMapper _outputMapper;
  late FieldValidationPolicy _validationPolicy;
  LibPhoneAsYouTypeFormatter? _libPhoneFormatter;

  List<TextInputFormatter>? _cachedFormatters;
  EphoneFieldType? _cachedFormatterType;
  Country? _cachedFormatterCountry;
  String? _cachedFormatterSplitter;
  PhoneNumberService? _cachedFormatterService;

  @override
  void initState() {
    super.initState();
    _type = widget.initialType;
    _selectedCountry = widget.initialCountry;
    _phoneService =
        widget.debugPhoneNumberService ?? PhoneNumberServiceFactory.create();
    _outputMapper = PhoneOutputMapper(_phoneService);
    _validationPolicy = FieldValidationPolicy();
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

    if (widget.debugPhoneNumberService != oldWidget.debugPhoneNumberService) {
      _phoneService =
          widget.debugPhoneNumberService ?? PhoneNumberServiceFactory.create();
      _outputMapper = PhoneOutputMapper(_phoneService);
      _invalidateFormatterCache();
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
    _libPhoneFormatter?.dispose();
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
              _outputMapper,
              widget.onChanged,
            )
            ?.call(value);
      },
      onSaved: (value) {
        widget
            .typeResolver(value ?? '', widget.initialType)
            .onSaved(
              _selectedCountry,
              _outputMapper,
              widget.onSaved,
            )
            ?.call(value);
      },
      onFieldSubmitted: (value) {
        widget
            .typeResolver(value, widget.initialType)
            .onFieldSubmitted(
              _selectedCountry,
              _outputMapper,
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
      validator: (value) {
        final validationContext = ValidationContext(
          phoneService: _phoneService,
          country: _selectedCountry,
          emptyErrorText: widget.emptyErrorText,
        );
        return ValidationBinding.run(validationContext, () {
          final resolved = _validationPolicy.resolve(
            type,
            userValidator: _userValidators[type],
            context: validationContext,
          );
          final wrapped = type.validator(
            resolved,
            _selectedCountry,
            _outputMapper,
          );
          return wrapped?.call(value);
        });
      },
      inputFormatters: _formattersForType(type),
    );
  }

  Map<EphoneFieldType, FormFieldValidator<String>?> get _userValidators =>
      <EphoneFieldType, FormFieldValidator<String>?>{
        EphoneFieldType.initial: null,
        EphoneFieldType.email: widget.emailValidator,
        EphoneFieldType.phone: widget.phoneValidator,
      };

  List<TextInputFormatter> _formattersForType(EphoneFieldType type) {
    if (widget.inputFormatters != null) {
      return widget.inputFormatters!;
    }

    final splitter = widget.phoneNumberMaskSplitter;
    if (_cachedFormatters != null &&
        _cachedFormatterType == type &&
        _cachedFormatterCountry == _selectedCountry &&
        _cachedFormatterSplitter == splitter &&
        identical(_cachedFormatterService, _phoneService)) {
      return _cachedFormatters!;
    }

    _libPhoneFormatter?.dispose();
    _libPhoneFormatter = null;

    if (type == EphoneFieldType.phone && _shouldUseLibPhoneFormatting) {
      _libPhoneFormatter = LibPhoneAsYouTypeFormatter(
        service: _phoneService,
        regionCode: _selectedCountry.alpha2,
      );
      _cachedFormatters = <TextInputFormatter>[
        _libPhoneFormatter!,
        PhoneNumberDigitsOnlyFormatter(maskSplitCharacter: splitter),
      ];
    } else {
      _cachedFormatters = type.inputFormatters(_selectedCountry, splitter);
    }

    _cachedFormatterType = type;
    _cachedFormatterCountry = _selectedCountry;
    _cachedFormatterSplitter = splitter;
    _cachedFormatterService = _phoneService;
    return _cachedFormatters!;
  }

  bool get _shouldUseLibPhoneFormatting =>
      widget.useLibPhoneFormatting &&
      _phoneService.supportsAsYouTypeFormatting;

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
    _libPhoneFormatter?.dispose();
    _libPhoneFormatter = null;
    _cachedFormatters = null;
    _cachedFormatterType = null;
    _cachedFormatterCountry = null;
    _cachedFormatterSplitter = null;
    _cachedFormatterService = null;
  }
}
