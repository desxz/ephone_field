// ignore_for_file: always_specify_types, type_annotate_public_apis
// ignore_for_file: camel_case_types, non_constant_identifier_names
// ignore_for_file: unused_element, unused_field
// GENERATED — do not edit by hand.
//
// Hand-written bootstrap matching src/ephone_phonenumber_c.h.
// Prefer regenerating with: dart run ffigen --config tool/ffigen.yaml

import 'dart:ffi' as ffi;

class EphonePhoneBindings {
  EphonePhoneBindings(ffi.DynamicLibrary dynamicLibrary)
    : _lookup = dynamicLibrary.lookup;

  EphonePhoneBindings.fromLookup(
    ffi.Pointer<T> Function<T extends ffi.NativeType>(String) lookup,
  ) : _lookup = lookup;

  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String) _lookup;

  late final _ephone_phone_api_versionPtr =
      _lookup<ffi.NativeFunction<ffi.Int32 Function()>>(
        'ephone_phone_api_version',
      );
  late final _ephone_phone_api_version =
      _ephone_phone_api_versionPtr.asFunction<int Function()>();

  int ephone_phone_api_version() => _ephone_phone_api_version();

  late final _ephone_phone_uses_libphonenumberPtr =
      _lookup<ffi.NativeFunction<ffi.Int32 Function()>>(
        'ephone_phone_uses_libphonenumber',
      );
  late final _ephone_phone_uses_libphonenumber =
      _ephone_phone_uses_libphonenumberPtr.asFunction<int Function()>();

  int ephone_phone_uses_libphonenumber() => _ephone_phone_uses_libphonenumber();

  late final _ephone_phone_util_createPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<EphonePhoneUtil> Function()>>(
        'ephone_phone_util_create',
      );
  late final _ephone_phone_util_create =
      _ephone_phone_util_createPtr
          .asFunction<ffi.Pointer<EphonePhoneUtil> Function()>();

  ffi.Pointer<EphonePhoneUtil> ephone_phone_util_create() =>
      _ephone_phone_util_create();

  late final _ephone_phone_util_destroyPtr = _lookup<
    ffi.NativeFunction<ffi.Void Function(ffi.Pointer<EphonePhoneUtil>)>
  >('ephone_phone_util_destroy');
  late final _ephone_phone_util_destroy =
      _ephone_phone_util_destroyPtr
          .asFunction<void Function(ffi.Pointer<EphonePhoneUtil>)>();

  void ephone_phone_util_destroy(ffi.Pointer<EphonePhoneUtil> util) =>
      _ephone_phone_util_destroy(util);

  late final _ephone_phone_is_validPtr = _lookup<
    ffi.NativeFunction<
      ffi.Int32 Function(
        ffi.Pointer<EphonePhoneUtil>,
        ffi.Pointer<ffi.Char>,
        ffi.Pointer<ffi.Char>,
      )
    >
  >('ephone_phone_is_valid');
  late final _ephone_phone_is_valid =
      _ephone_phone_is_validPtr
          .asFunction<
            int Function(
              ffi.Pointer<EphonePhoneUtil>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
            )
          >();

  int ephone_phone_is_valid(
    ffi.Pointer<EphonePhoneUtil> util,
    ffi.Pointer<ffi.Char> raw,
    ffi.Pointer<ffi.Char> region_code,
  ) => _ephone_phone_is_valid(util, raw, region_code);

  late final _ephone_phone_is_possiblePtr = _lookup<
    ffi.NativeFunction<
      ffi.Int32 Function(
        ffi.Pointer<EphonePhoneUtil>,
        ffi.Pointer<ffi.Char>,
        ffi.Pointer<ffi.Char>,
      )
    >
  >('ephone_phone_is_possible');
  late final _ephone_phone_is_possible =
      _ephone_phone_is_possiblePtr
          .asFunction<
            int Function(
              ffi.Pointer<EphonePhoneUtil>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
            )
          >();

  int ephone_phone_is_possible(
    ffi.Pointer<EphonePhoneUtil> util,
    ffi.Pointer<ffi.Char> raw,
    ffi.Pointer<ffi.Char> region_code,
  ) => _ephone_phone_is_possible(util, raw, region_code);

  late final _ephone_phone_format_e164Ptr = _lookup<
    ffi.NativeFunction<
      ffi.Int32 Function(
        ffi.Pointer<EphonePhoneUtil>,
        ffi.Pointer<ffi.Char>,
        ffi.Pointer<ffi.Char>,
        ffi.Pointer<ffi.Char>,
        ffi.Int32,
      )
    >
  >('ephone_phone_format_e164');
  late final _ephone_phone_format_e164 =
      _ephone_phone_format_e164Ptr
          .asFunction<
            int Function(
              ffi.Pointer<EphonePhoneUtil>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
              int,
            )
          >();

  int ephone_phone_format_e164(
    ffi.Pointer<EphonePhoneUtil> util,
    ffi.Pointer<ffi.Char> raw,
    ffi.Pointer<ffi.Char> region_code,
    ffi.Pointer<ffi.Char> out,
    int out_len,
  ) => _ephone_phone_format_e164(util, raw, region_code, out, out_len);

  late final _ephone_phone_format_nationalPtr = _lookup<
    ffi.NativeFunction<
      ffi.Int32 Function(
        ffi.Pointer<EphonePhoneUtil>,
        ffi.Pointer<ffi.Char>,
        ffi.Pointer<ffi.Char>,
        ffi.Pointer<ffi.Char>,
        ffi.Int32,
      )
    >
  >('ephone_phone_format_national');
  late final _ephone_phone_format_national =
      _ephone_phone_format_nationalPtr
          .asFunction<
            int Function(
              ffi.Pointer<EphonePhoneUtil>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
              int,
            )
          >();

  int ephone_phone_format_national(
    ffi.Pointer<EphonePhoneUtil> util,
    ffi.Pointer<ffi.Char> raw,
    ffi.Pointer<ffi.Char> region_code,
    ffi.Pointer<ffi.Char> out,
    int out_len,
  ) => _ephone_phone_format_national(util, raw, region_code, out, out_len);

  late final _ephone_asyoutype_createPtr = _lookup<
    ffi.NativeFunction<
      ffi.Pointer<EphoneAsYouType> Function(
        ffi.Pointer<EphonePhoneUtil>,
        ffi.Pointer<ffi.Char>,
      )
    >
  >('ephone_asyoutype_create');
  late final _ephone_asyoutype_create =
      _ephone_asyoutype_createPtr
          .asFunction<
            ffi.Pointer<EphoneAsYouType> Function(
              ffi.Pointer<EphonePhoneUtil>,
              ffi.Pointer<ffi.Char>,
            )
          >();

  ffi.Pointer<EphoneAsYouType> ephone_asyoutype_create(
    ffi.Pointer<EphonePhoneUtil> util,
    ffi.Pointer<ffi.Char> region_code,
  ) => _ephone_asyoutype_create(util, region_code);

  late final _ephone_asyoutype_destroyPtr = _lookup<
    ffi.NativeFunction<ffi.Void Function(ffi.Pointer<EphoneAsYouType>)>
  >('ephone_asyoutype_destroy');
  late final _ephone_asyoutype_destroy =
      _ephone_asyoutype_destroyPtr
          .asFunction<void Function(ffi.Pointer<EphoneAsYouType>)>();

  void ephone_asyoutype_destroy(ffi.Pointer<EphoneAsYouType> session) =>
      _ephone_asyoutype_destroy(session);

  late final _ephone_asyoutype_input_digitPtr = _lookup<
    ffi.NativeFunction<
      ffi.Int32 Function(
        ffi.Pointer<EphoneAsYouType>,
        ffi.Int32,
        ffi.Pointer<ffi.Char>,
        ffi.Int32,
      )
    >
  >('ephone_asyoutype_input_digit');
  late final _ephone_asyoutype_input_digit =
      _ephone_asyoutype_input_digitPtr
          .asFunction<
            int Function(
              ffi.Pointer<EphoneAsYouType>,
              int,
              ffi.Pointer<ffi.Char>,
              int,
            )
          >();

  int ephone_asyoutype_input_digit(
    ffi.Pointer<EphoneAsYouType> session,
    int code_point,
    ffi.Pointer<ffi.Char> out,
    int out_len,
  ) => _ephone_asyoutype_input_digit(session, code_point, out, out_len);

  late final _ephone_asyoutype_clearPtr = _lookup<
    ffi.NativeFunction<ffi.Void Function(ffi.Pointer<EphoneAsYouType>)>
  >('ephone_asyoutype_clear');
  late final _ephone_asyoutype_clear =
      _ephone_asyoutype_clearPtr
          .asFunction<void Function(ffi.Pointer<EphoneAsYouType>)>();

  void ephone_asyoutype_clear(ffi.Pointer<EphoneAsYouType> session) =>
      _ephone_asyoutype_clear(session);

  late final _ephone_phone_parsePtr = _lookup<
    ffi.NativeFunction<
      ffi.Int32 Function(
        ffi.Pointer<EphonePhoneUtil>,
        ffi.Pointer<ffi.Char>,
        ffi.Pointer<ffi.Char>,
        ffi.Pointer<ffi.Char>,
        ffi.Int32,
        ffi.Pointer<ffi.Char>,
        ffi.Int32,
        ffi.Pointer<ffi.Int32>,
      )
    >
  >('ephone_phone_parse');
  late final _ephone_phone_parse =
      _ephone_phone_parsePtr
          .asFunction<
            int Function(
              ffi.Pointer<EphonePhoneUtil>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
              int,
              ffi.Pointer<ffi.Char>,
              int,
              ffi.Pointer<ffi.Int32>,
            )
          >();

  int ephone_phone_parse(
    ffi.Pointer<EphonePhoneUtil> util,
    ffi.Pointer<ffi.Char> raw,
    ffi.Pointer<ffi.Char> region_code,
    ffi.Pointer<ffi.Char> e164_out,
    int e164_len,
    ffi.Pointer<ffi.Char> national_out,
    int national_len,
    ffi.Pointer<ffi.Int32> country_code_out,
  ) => _ephone_phone_parse(
    util,
    raw,
    region_code,
    e164_out,
    e164_len,
    national_out,
    national_len,
    country_code_out,
  );
}

final class EphonePhoneUtil extends ffi.Opaque {}

final class EphoneAsYouType extends ffi.Opaque {}
