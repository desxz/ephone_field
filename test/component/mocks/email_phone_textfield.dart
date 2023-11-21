import 'package:ephone_field/ephone_field.dart';
import 'package:flutter/material.dart';

class EPhoneFieldMock extends StatelessWidget {
  const EPhoneFieldMock(
      {Key? key,
      required this.emailValidator,
      required this.phoneValidator,
      this.onChanged,
      this.onCountryChanged})
      : super(key: key);
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? phoneValidator;
  final void Function(String)? onChanged;
  final void Function(Country)? onCountryChanged;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: EPhoneField(
          emailValidator: emailValidator,
          phoneValidator: phoneValidator,
          onChanged: onChanged,
          onCountryChanged: onCountryChanged,
        ),
      ),
    );
  }
}
