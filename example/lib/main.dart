import 'package:ephone_field/ephone_field.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EphoneFieldDemoApp());
}

class EphoneFieldDemoApp extends StatelessWidget {
  const EphoneFieldDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ephone Field Demo',
      home: EphoneFieldDemoPage(),
    );
  }
}

class EphoneFieldDemoPage extends StatefulWidget {
  const EphoneFieldDemoPage({super.key});

  @override
  State<EphoneFieldDemoPage> createState() => _EphoneFieldDemoPageState();
}

class _EphoneFieldDemoPageState extends State<EphoneFieldDemoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  PickerMenuType _menuType = PickerMenuType.bottomSheet;
  Country _selectedCountry = Country.unitedStates;
  EphoneFieldType _detectedType = EphoneFieldType.initial;
  String? _statusMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _statusMessage =
            'Valid ${_detectedType.name} input: ${_controller.text}';
      });
    } else {
      setState(() {
        _statusMessage = 'Validation failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ephone Field Demo'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DropdownButtonFormField<PickerMenuType>(
              value: _menuType,
              decoration: const InputDecoration(
                labelText: 'Country picker style',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: PickerMenuType.dialog,
                  child: Text('Dialog'),
                ),
                DropdownMenuItem(
                  value: PickerMenuType.bottomSheet,
                  child: Text('Bottom sheet'),
                ),
                DropdownMenuItem(
                  value: PickerMenuType.page,
                  child: Text('Page'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _menuType = value);
                }
              },
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: EPhoneField(
                controller: _controller,
                title: 'Select Country',
                menuType: _menuType,
                pickerHeight: CountryPickerHeight.h50,
                initialCountry: Country.turkey,
                phoneNumberMaskSplitter: ' ',
                emailValidator: EphoneFieldValidators.email,
                phoneValidator: (value) =>
                    EphoneFieldValidators.phone(_selectedCountry)(value),
                onTypeChanged: (type) => setState(() => _detectedType = type),
                onCountryChanged: (country) {
                  setState(() => _selectedCountry = country);
                },
              ),
            ),
            const SizedBox(height: 16),
            Text('Detected type: ${_detectedType.name}'),
            Text(
                'Selected country: ${_selectedCountry.name} (+${_selectedCountry.dialCode})'),
            if (_statusMessage != null) ...[
              const SizedBox(height: 8),
              Text(_statusMessage!),
            ],
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _submit,
              child: const Text('Validate'),
            ),
          ],
        ),
      ),
    );
  }
}
