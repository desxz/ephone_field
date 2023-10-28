import 'package:ephone_field/ephone_field.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ephone Field Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ephone Field Demo'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: EPhoneField(
                  menuType: PickerMenuType.bottomSheet,
                  initialCountry: Country.afghanistan,
                  pickerHeight: CountryPickerHeigth.h50,
                  onCountryChanged: (Country? country) {
                    // Add your code here after country selected
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
