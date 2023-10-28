import 'package:ephone_field/src/email_phone_textfield.dart';
import 'package:flutter/material.dart';

class EPhoneFieldMock extends StatelessWidget {
  const EPhoneFieldMock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: EPhoneField(),
      ),
    );
  }
}
