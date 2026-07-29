import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'application/phone/phone_output_mapper.dart';
import 'components/country_picker_button.dart';
import 'config/config.dart';
import 'domain/phone/phone_number_service.dart';
import 'enums/country.dart';
import 'enums/ephone_textfield_type.dart';
import 'formatters/formatters.dart';
import 'infrastructure/phone/phone_number_service_factory.dart';
import 'validation/field_validator_resolver.dart';
import 'validation/validation_binding.dart';
import 'validation/validation_context.dart';

/// A versatile [TextFormField] for email and phone number input.
class EPhoneField extends StatefulWidget {
  /// Creates an email/phone input field.
  ///
  /// When [emailValidator] / [phoneValidator] are omitted, package defaults
  /// run. Pass a custom validator to override, or use [Validators.compose] to
  /// combine package rules with extra conditions.
  ///
  /// Pass `(value) => null` to disable validation for that mode.
  const EPhoneField({
    super.key,
    // Core
    this.controller,
    this.focusNode,
    this.initialValue,
    this.initialType = EphoneFieldType.initial,
    this.initialCountry = Country.unitedStates,
    // Grouped config
    this.countryPicker = const CountryPickerConfig(),
    this.labels = const EPhoneFieldLabels(),
    // Form
    this.decoration = const InputDecoration(border: OutlineInputBorder()),
    this.autovalidateMode,
    this.clearErrorOnChange = true,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onCountryChanged,
    this.onTypeChanged,
    this.emailValidator,
    this.phoneValidator,
    this.inputFormatters,
    // TextFormField chrome
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect,
    this.enableSuggestions,
    this.smartDashesType,
    this.smartQuotesType,
    this.showCursor,
    this.cursorColor,
    this.cursorErrorColor,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.scrollPadding = const EdgeInsets.all(20),
    this.scrollPhysics,
    this.scrollController,
    this.keyboardAppearance,
    this.enableInteractiveSelection,
    this.selectAllOnFocus,
    this.canRequestFocus = true,
    this.ignorePointers,
    this.restorationId,
    this.mouseCursor,
    this.clipBehavior = Clip.hardEdge,
    this.forceErrorText,
    this.errorBuilder,
    this.contextMenuBuilder,
    this.enableIMEPersonalizedLearning = true,
    this.onTap,
    this.onTapOutside,
    this.onTapUpOutside,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    // Advanced
    this.typeResolver = defaultEphoneFieldTypeResolver,
    this.useLibPhoneFormatting = true,
    this.phoneNumberMaskSplitter = ' ',
    @visibleForTesting this.debugPhoneNumberService,
  });

  /// Text editing controller for the input field.
  final TextEditingController? controller;

  /// Focus node for the input field.
  final FocusNode? focusNode;

  /// Initial text value when no [controller] is supplied.
  final String? initialValue;

  /// Initial field type when empty.
  final EphoneFieldType initialType;

  /// Initial selected country.
  final Country initialCountry;

  /// Country picker presentation and list settings.
  final CountryPickerConfig countryPicker;

  /// Field labels and empty-state copy.
  final EPhoneFieldLabels labels;

  /// Decoration for the main input field.
  final InputDecoration decoration;

  /// Autovalidate mode for the form field.
  final AutovalidateMode? autovalidateMode;

  /// When true (default), clears the field error after a failed validate as soon
  /// as the user edits the text or changes country. Set false to keep the error
  /// until the next explicit [FormState.validate]. Ignored when [autovalidateMode]
  /// is not [AutovalidateMode.disabled].
  final bool clearErrorOnChange;

  /// Called when the text changes.
  final void Function(String)? onChanged;

  /// Called when the field is saved.
  final void Function(String?)? onSaved;

  /// Called when the field is submitted.
  final void Function(String?)? onFieldSubmitted;

  /// Called when the selected country changes.
  final ValueChanged<Country>? onCountryChanged;

  /// Called when the detected field type changes.
  final ValueChanged<EphoneFieldType>? onTypeChanged;

  /// Validator for email input.
  final String? Function(String?)? emailValidator;

  /// Validator for phone input (receives full international number).
  final String? Function(String?)? phoneValidator;

  /// Optional custom input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether the field accepts input.
  final bool enabled;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Whether the field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Text style for the input.
  final TextStyle? style;

  /// Strut style for the input.
  final StrutStyle? strutStyle;

  /// Text alignment.
  final TextAlign textAlign;

  /// Vertical alignment of the text.
  final TextAlignVertical? textAlignVertical;

  /// Text reading direction.
  final TextDirection? textDirection;

  /// Keyboard action button.
  final TextInputAction? textInputAction;

  /// Text capitalization behavior.
  final TextCapitalization textCapitalization;

  /// Whether to enable autocorrect. Defaults to off in phone mode.
  final bool? autocorrect;

  /// Whether to show input suggestions. Defaults to on in email mode only.
  final bool? enableSuggestions;

  /// Smart dashes behavior. Defaults to disabled in phone mode.
  final SmartDashesType? smartDashesType;

  /// Smart quotes behavior. Defaults to disabled in phone mode.
  final SmartQuotesType? smartQuotesType;

  /// Whether to show the cursor.
  final bool? showCursor;

  /// Cursor color.
  final Color? cursorColor;

  /// Cursor color when the field has a validation error.
  final Color? cursorErrorColor;

  /// Cursor width.
  final double cursorWidth;

  /// Cursor height.
  final double? cursorHeight;

  /// Cursor corner radius.
  final Radius? cursorRadius;

  /// Padding around the field when scrolled into view.
  final EdgeInsets scrollPadding;

  /// Scroll physics for the internal scrollable.
  final ScrollPhysics? scrollPhysics;

  /// Scroll controller for the internal scrollable.
  final ScrollController? scrollController;

  /// Keyboard appearance (light/dark).
  final Brightness? keyboardAppearance;

  /// Whether text selection is interactive.
  final bool? enableInteractiveSelection;

  /// Whether to select all text when the field gains focus.
  final bool? selectAllOnFocus;

  /// Whether the field can request focus.
  final bool canRequestFocus;

  /// Whether pointers are ignored (field still participates in hit testing).
  final bool? ignorePointers;

  /// Restoration ID for form state.
  final String? restorationId;

  /// Mouse cursor when hovering the field.
  final MouseCursor? mouseCursor;

  /// Clip behavior for the underlying [TextField].
  final Clip clipBehavior;

  /// Forces an error to be displayed without running the validator.
  final String? forceErrorText;

  /// Custom builder for the error message below the field.
  final FormFieldErrorBuilder? errorBuilder;

  /// Custom context menu builder for text selection.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Whether to enable IME personalized learning.
  final bool enableIMEPersonalizedLearning;

  /// Called when the field is tapped.
  final GestureTapCallback? onTap;

  /// Called when a tap occurs outside the field.
  final TapRegionCallback? onTapOutside;

  /// Called when a tap up occurs outside the field.
  final TapRegionUpCallback? onTapUpOutside;

  /// Whether [onTap] is called for every tap, including after focus.
  final bool onTapAlwaysCalled;

  /// Called when editing is completed.
  final VoidCallback? onEditingComplete;

  /// Custom resolver for email vs phone detection.
  final EphoneFieldTypeResolver typeResolver;

  /// When true and a native-capable service is available, use AsYouType.
  final bool useLibPhoneFormatting;

  /// Mask separator used while formatting phone numbers (legacy mask path).
  final String? phoneNumberMaskSplitter;

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
  LibPhoneAsYouTypeFormatter? _libPhoneFormatter;
  final GlobalKey<FormFieldState<String>> _fieldKey =
      GlobalKey<FormFieldState<String>>();
  bool _suppressErrorOnce = false;

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

  bool get _shouldClearErrorOnEdit {
    if (!widget.clearErrorOnChange) {
      return false;
    }
    final mode = widget.autovalidateMode ?? AutovalidateMode.disabled;
    return mode == AutovalidateMode.disabled;
  }

  void _maybeClearValidationError() {
    if (!_shouldClearErrorOnEdit) {
      return;
    }
    final fieldState = _fieldKey.currentState;
    if (fieldState == null || !fieldState.hasError) {
      return;
    }
    _suppressErrorOnce = true;
    fieldState.validate();
    _suppressErrorOnce = false;
  }

  @override
  Widget build(BuildContext context) {
    final type = _resolvedType;
    final isPhone = type == EphoneFieldType.phone;

    return TextFormField(
      key: _fieldKey,
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      autocorrect: widget.autocorrect ?? !isPhone,
      enableSuggestions: widget.enableSuggestions ?? !isPhone,
      smartDashesType: widget.smartDashesType ??
          (isPhone ? SmartDashesType.disabled : null),
      smartQuotesType: widget.smartQuotesType ??
          (isPhone ? SmartQuotesType.disabled : null),
      showCursor: widget.showCursor,
      cursorColor: widget.cursorColor,
      cursorErrorColor: widget.cursorErrorColor,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      scrollPadding: widget.scrollPadding,
      scrollPhysics: widget.scrollPhysics,
      scrollController: widget.scrollController,
      keyboardAppearance: widget.keyboardAppearance,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectAllOnFocus: widget.selectAllOnFocus,
      canRequestFocus: widget.canRequestFocus,
      ignorePointers: widget.ignorePointers,
      restorationId: widget.restorationId,
      mouseCursor: widget.mouseCursor,
      clipBehavior: widget.clipBehavior,
      forceErrorText: widget.forceErrorText,
      errorBuilder: widget.errorBuilder,
      contextMenuBuilder: widget.contextMenuBuilder,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      onTapUpOutside: widget.onTapUpOutside,
      onTapAlwaysCalled: widget.onTapAlwaysCalled,
      onEditingComplete: widget.onEditingComplete,
      autovalidateMode: widget.autovalidateMode,
      autofillHints: type.autofillHints,
      maxLines: 1,
      onChanged: (value) {
        _maybeClearValidationError();
        final changedType =
            widget.typeResolver(value, widget.initialType);
        changedType
            .onChanged(_selectedCountry, _outputMapper, widget.onChanged)
            ?.call(value);
      },
      onSaved: (value) {
        final savedType =
            widget.typeResolver(value ?? '', widget.initialType);
        savedType
            .onSaved(_selectedCountry, _outputMapper, widget.onSaved)
            ?.call(value);
      },
      onFieldSubmitted: (value) {
        final submittedType =
            widget.typeResolver(value, widget.initialType);
        submittedType
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
          widget.labels.empty,
          widget.labels.email,
          widget.labels.phone,
        ),
      ),
      keyboardType: type.keyboardType,
      validator: (value) {
        if (_suppressErrorOnce) {
          return null;
        }
        final fieldType =
            widget.typeResolver(value ?? '', widget.initialType);
        final validationContext = ValidationContext(
          phoneService: _phoneService,
          country: _selectedCountry,
          emptyErrorText: widget.labels.emptyErrorText,
        );
        return ValidationBinding.run(validationContext, () {
          final resolved = resolveFieldValidator(
            fieldType,
            userValidator: _userValidatorFor(fieldType),
            context: validationContext,
          );
          final wrapped = fieldType.validator(
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

  FormFieldValidator<String>? _userValidatorFor(EphoneFieldType type) {
    switch (type) {
      case EphoneFieldType.initial:
        return null;
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
      config: widget.countryPicker,
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
      if (_libPhoneFormatter != null &&
          _cachedFormatterType == EphoneFieldType.phone &&
          _shouldUseLibPhoneFormatting) {
        _libPhoneFormatter!.updateRegion(country.alpha2);
        _cachedFormatterCountry = country;
      } else {
        _invalidateFormatterCache();
      }
    });
    widget.onCountryChanged?.call(country);
    _maybeClearValidationError();
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
