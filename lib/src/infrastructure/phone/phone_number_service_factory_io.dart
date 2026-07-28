import '../../domain/phone/phone_number_service.dart';
import 'ffi/ffi_phone_number_service.dart';
import 'stub/unsupported_phone_number_service.dart';

/// Native platforms: prefer FFI, otherwise unsupported stub.
PhoneNumberService createPhoneNumberService() {
  return FfiPhoneNumberService.tryCreate() ??
      const UnsupportedPhoneNumberService();
}
