import 'package:flutter/widgets.dart';

/// Chain-of-responsibility helpers for [FormFieldValidator]s.
abstract final class Validators {
  /// Runs [validators] in order; returns the first non-null error.
  static FormFieldValidator<String> compose(
    List<FormFieldValidator<String>> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }

  /// Runs [base] then [extra] (fail-fast).
  static FormFieldValidator<String> andThen(
    FormFieldValidator<String> base,
    FormFieldValidator<String> extra,
  ) =>
      compose(<FormFieldValidator<String>>[base, extra]);
}
