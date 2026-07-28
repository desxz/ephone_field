import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import '../../../domain/phone/phone.dart';
import 'phone_number_bindings.dart';

/// [PhoneNumberService] backed by the native `ephone_field` FFI library.
class FfiPhoneNumberService implements PhoneNumberService {
  FfiPhoneNumberService._(
    this._bindings,
    this._util,
    this._usesLibPhoneNumber,
  );

  final EphonePhoneBindings _bindings;
  final Pointer<EphonePhoneUtil> _util;
  final bool _usesLibPhoneNumber;

  static const int _bufferSize = 64;

  /// Opens the native library and creates a util handle.
  ///
  /// Returns `null` when the dynamic library cannot be loaded (for example on
  /// pure-Dart unit test hosts without a built plugin).
  static FfiPhoneNumberService? tryCreate() {
    try {
      final dylib = _openLibrary();
      final bindings = EphonePhoneBindings(dylib);
      final version = bindings.ephone_phone_api_version();
      if (version < 1) {
        return null;
      }
      final util = bindings.ephone_phone_util_create();
      if (util == nullptr) {
        return null;
      }
      final usesLibPhoneNumber =
          bindings.ephone_phone_uses_libphonenumber() == 1;
      return FfiPhoneNumberService._(bindings, util, usesLibPhoneNumber);
    } on Object {
      return null;
    }
  }

  static DynamicLibrary _openLibrary() {
    const libName = 'ephone_field';
    if (Platform.isMacOS || Platform.isIOS) {
      return DynamicLibrary.open('$libName.framework/$libName');
    }
    if (Platform.isAndroid || Platform.isLinux) {
      return DynamicLibrary.open('lib$libName.so');
    }
    if (Platform.isWindows) {
      return DynamicLibrary.open('$libName.dll');
    }
    throw UnsupportedError(
      'Unsupported platform: ${Platform.operatingSystem}',
    );
  }

  /// Native API version (hello round-trip).
  int get apiVersion => _bindings.ephone_phone_api_version();

  @override
  bool get supportsAsYouTypeFormatting => _usesLibPhoneNumber;

  @override
  bool isValid(String raw, {required String regionCode}) {
    return _withUtf8(raw, regionCode, (rawPtr, regionPtr) {
      return _bindings.ephone_phone_is_valid(_util, rawPtr, regionPtr) == 1;
    });
  }

  @override
  bool isPossible(String raw, {required String regionCode}) {
    return _withUtf8(raw, regionCode, (rawPtr, regionPtr) {
      return _bindings.ephone_phone_is_possible(_util, rawPtr, regionPtr) == 1;
    });
  }

  @override
  PhoneParseResult? parse(String raw, {required String regionCode}) {
    final e164 = formatE164(raw, regionCode: regionCode);
    if (e164 == null) {
      return null;
    }
    final national = formatNational(raw, regionCode: regionCode);
    return PhoneParseResult(
      e164: e164,
      nationalNumber: (national ?? e164).replaceAll(RegExp(r'\D'), ''),
      countryCode: 0,
      regionCode: regionCode.toUpperCase(),
    );
  }

  @override
  String? formatE164(String raw, {required String regionCode}) {
    return _format(
      raw,
      regionCode,
      _bindings.ephone_phone_format_e164,
    );
  }

  @override
  String? formatNational(String raw, {required String regionCode}) {
    return _format(
      raw,
      regionCode,
      _bindings.ephone_phone_format_national,
    );
  }

  @override
  AsYouTypeSession createAsYouType(String regionCode) {
    return using((Arena arena) {
      final regionPtr = regionCode.toNativeUtf8(allocator: arena).cast<Char>();
      final session = _bindings.ephone_asyoutype_create(_util, regionPtr);
      if (session == nullptr) {
        throw StateError('Failed to create AsYouType session for $regionCode');
      }
      return _FfiAsYouTypeSession(_bindings, session);
    });
  }

  String? _format(
    String raw,
    String regionCode,
    int Function(
      Pointer<EphonePhoneUtil>,
      Pointer<Char>,
      Pointer<Char>,
      Pointer<Char>,
      int,
    ) formatFn,
  ) {
    return using((Arena arena) {
      final rawPtr = raw.toNativeUtf8(allocator: arena).cast<Char>();
      final regionPtr = regionCode.toNativeUtf8(allocator: arena).cast<Char>();
      final out = arena<Uint8>(_bufferSize).cast<Char>();
      final ok = formatFn(_util, rawPtr, regionPtr, out, _bufferSize);
      if (ok != 1) {
        return null;
      }
      return out.cast<Utf8>().toDartString();
    });
  }

  T _withUtf8<T>(
    String raw,
    String regionCode,
    T Function(Pointer<Char> rawPtr, Pointer<Char> regionPtr) body,
  ) {
    return using((Arena arena) {
      final rawPtr = raw.toNativeUtf8(allocator: arena).cast<Char>();
      final regionPtr = regionCode.toNativeUtf8(allocator: arena).cast<Char>();
      return body(rawPtr, regionPtr);
    });
  }

  /// Releases the native util handle.
  void dispose() {
    _bindings.ephone_phone_util_destroy(_util);
  }
}

class _FfiAsYouTypeSession implements AsYouTypeSession {
  _FfiAsYouTypeSession(this._bindings, this._session);

  final EphonePhoneBindings _bindings;
  final Pointer<EphoneAsYouType> _session;
  bool _disposed = false;

  static const int _bufferSize = 64;

  @override
  String inputDigit(String digit) {
    if (_disposed) {
      throw StateError('AsYouTypeSession already disposed');
    }
    if (digit.isEmpty) {
      return '';
    }
    return using((Arena arena) {
      final out = arena<Uint8>(_bufferSize).cast<Char>();
      final ok = _bindings.ephone_asyoutype_input_digit(
        _session,
        digit.codeUnitAt(0),
        out,
        _bufferSize,
      );
      if (ok != 1) {
        return '';
      }
      return out.cast<Utf8>().toDartString();
    });
  }

  @override
  void clear() {
    if (_disposed) {
      return;
    }
    _bindings.ephone_asyoutype_clear(_session);
  }

  @override
  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _bindings.ephone_asyoutype_destroy(_session);
  }
}
