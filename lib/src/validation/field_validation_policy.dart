import 'package:flutter/widgets.dart';

import '../enums/ephone_textfield_type.dart';
import 'field_validation_strategies.dart';
import 'field_validation_strategy.dart';

/// Maps [EphoneFieldType] to a [FieldValidationStrategy] (registry, not switch).
class FieldValidationPolicy {
  /// Creates a policy with the default strategy registry.
  FieldValidationPolicy()
      : this.withStrategies(const <EphoneFieldType, FieldValidationStrategy>{
          EphoneFieldType.initial: InitialValidationStrategy(),
          EphoneFieldType.email: EmailValidationStrategy(),
          EphoneFieldType.phone: PhoneValidationStrategy(),
        });

  /// Creates a policy with an explicit strategy map (tests / extension).
  FieldValidationPolicy.withStrategies(this._strategies);

  final Map<EphoneFieldType, FieldValidationStrategy> _strategies;

  /// Resolves the validator for [type].
  FormFieldValidator<String>? resolve(
    EphoneFieldType type, {
    required FormFieldValidator<String>? userValidator,
    required ValidationContext context,
  }) {
    final strategy = _strategies[type];
    assert(strategy != null, 'No FieldValidationStrategy for $type');
    return strategy!.resolve(
      userValidator: userValidator,
      context: context,
    );
  }
}
