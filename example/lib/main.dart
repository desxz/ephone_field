import 'package:ephone_field/ephone_field.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
                  title: "Select Country",
                  menuType: PickerMenuType.bottomSheet,
                  initialCountry: Country.afghanistan,
                  emailValidator: (String? email) {
                    if (email == null || email.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  phoneValidator: (String? phone) {
                    if (phone == null || phone.isEmpty) {
                      return 'Phone is required';
                    }
                    return null;
                  },
                  pickerHeight: CountryPickerHeigth.h50, // Not Effective in PickerMenuType.page
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
