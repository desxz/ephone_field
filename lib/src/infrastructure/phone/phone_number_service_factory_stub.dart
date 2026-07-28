import '../../domain/phone/phone_number_service.dart';
import 'stub/unsupported_phone_number_service.dart';

/// Default when `dart:ffi` is unavailable (for example web).
PhoneNumberService createPhoneNumberService() =>
    const UnsupportedPhoneNumberService();
