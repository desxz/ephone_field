/// Label and empty-state copy for [EPhoneField].
class EPhoneFieldLabels {
  /// Creates field labels.
  const EPhoneFieldLabels({
    this.empty = 'Email or phone number',
    this.email = 'Email',
    this.phone = 'Phone number',
    this.emptyErrorText,
  });

  /// Label when the field is empty.
  final String empty;

  /// Label in email mode.
  final String email;

  /// Label in phone mode.
  final String phone;

  /// Error text when the field is empty in initial mode.
  final String? emptyErrorText;
}
