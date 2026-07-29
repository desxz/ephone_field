import 'validation_context.dart';

/// Holds the active [ValidationContext] while an [EPhoneField] validator runs.
abstract final class ValidationBinding {
  static ValidationContext? _current;

  /// Active context, or `null` outside a [run] call.
  static ValidationContext? get current => _current;

  /// Runs [body] with [context] bound for [PhoneValidators.phone].
  static T run<T>(ValidationContext context, T Function() body) {
    final previous = _current;
    _current = context;
    try {
      return body();
    } finally {
      _current = previous;
    }
  }

  /// Returns the bound context or throws if missing.
  static ValidationContext requireCurrent() {
    final context = _current;
    if (context == null) {
      throw StateError(
        'PhoneValidators.phone requires an active ValidationBinding. '
        'Use it as an EPhoneField validator (or inside ValidationBinding.run).',
      );
    }
    return context;
  }
}
