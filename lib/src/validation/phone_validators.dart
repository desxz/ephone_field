import 'phone_validity_check.dart';
import 'validation_binding.dart';
import 'validation_context.dart';

/// Package phone [FormField] validators (also used as EPhoneField defaults).
abstract final class PhoneValidators {
  /// Package default phone validator — same call shape as [EmailValidators.email].
  ///
  /// Reads country and phone capability from [ValidationBinding] (set by
  /// [EPhoneField] while validating).
  static String? phone(
    String? value, {
    String emptyMessage = 'Phone number is required',
    String invalidMessage = 'Enter a valid phone number',
  }) {
    return phoneWith(
      value,
      ValidationBinding.requireCurrent(),
      emptyMessage: emptyMessage,
      invalidMessage: invalidMessage,
    );
  }

  /// Same rules as [phone], with an explicit [context] (tests / advanced).
  static String? phoneWith(
    String? value,
    ValidationContext context, {
    String emptyMessage = 'Phone number is required',
    String invalidMessage = 'Enter a valid phone number',
    PhoneValidityCheck? validityCheck,
  }) {
    if (value == null || value.isEmpty) {
      return emptyMessage;
    }
    final check = validityCheck ??
        PhoneValidityCheck.forService(
          service: context.phoneService,
          country: context.country,
        );
    if (!check.isValid(value)) {
      return invalidMessage;
    }
    return null;
  }
}
