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

  String? _statusMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _statusMessage = 'Valid input: ${_controller.text}';
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
            Form(
              key: _formKey,
              child: EPhoneField(
                controller: _controller,
                initialCountry: Country.turkey,
                countryPicker: const CountryPickerConfig(
                  menuType: PickerMenuType.bottomSheet,
                  title: 'Select Country',
                ),
                labels: const EPhoneFieldLabels(
                  empty: 'Email or phone number',
                  phone: 'Phone number',
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(height: 16),
            if (_statusMessage != null) Text(_statusMessage!),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _submit,
              child: const Text('Validate'),
            ),
            const SizedBox(height: 32),
            const Text(
              'Advanced: compose validators or customize picker via '
              'CountryPickerConfig.',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
