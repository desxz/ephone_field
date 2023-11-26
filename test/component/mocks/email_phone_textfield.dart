import 'package:ephone_field/ephone_field.dart';
import 'package:flutter/material.dart';

class EPhoneFieldMock extends StatelessWidget {
  const EPhoneFieldMock(
      {Key? key,
      required this.emailValidator,
      required this.phoneValidator,
      this.onChanged,
      this.onCountryChanged,
      this.onSaved,
      this.onFieldSubmitted,
      required this.formKey,
      required this.emptyErrorText})
      : super(key: key);
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? phoneValidator;
  final void Function(String)? onChanged;
  final void Function(Country)? onCountryChanged;
  final void Function(String?)? onSaved;
  final void Function(String?)? onFieldSubmitted;
  final String emptyErrorText;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: formKey,
          child: EPhoneField(
            emptyErrorText: emptyErrorText,
            emailValidator: emailValidator,
            phoneValidator: phoneValidator,
            onChanged: onChanged,
            onCountryChanged: onCountryChanged,
            onSaved: onSaved,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ),
      ),
    );
  }
}
