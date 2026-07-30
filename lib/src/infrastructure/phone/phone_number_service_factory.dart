import '../../domain/phone/phone_number_service.dart';
import 'phone_number_service_factory_stub.dart'
    if (dart.library.ffi) 'phone_number_service_factory_io.dart'
    as impl;

/// Resolves the best available [PhoneNumberService] for the current platform.
abstract final class PhoneNumberServiceFactory {
  /// Prefer native FFI; fall back to [UnsupportedPhoneNumberService].
  static PhoneNumberService create() => impl.createPhoneNumberService();
}
