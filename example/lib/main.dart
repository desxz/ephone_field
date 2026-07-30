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
  final TextEditingController _pickerDemoController = TextEditingController();

  PickerMenuType _pickerMenuType = PickerMenuType.dialog;
  String? _statusMessage;

  @override
  void dispose() {
    _controller.dispose();
    _pickerDemoController.dispose();
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

  String _pickerLabel(PickerMenuType type) {
    switch (type) {
      case PickerMenuType.bottomSheet:
        return 'Bottom sheet';
      case PickerMenuType.dialog:
        return 'Dialog';
      case PickerMenuType.page:
        return 'Page';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ephone Field Demo')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EPhoneField(
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
                  const SizedBox(height: 24),
                  Text(
                    'Country picker type',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<PickerMenuType>(
                    segments: [
                      for (final type in PickerMenuType.values)
                        ButtonSegment(
                          value: type,
                          label: Text(_pickerLabel(type)),
                        ),
                    ],
                    selected: {_pickerMenuType},
                    onSelectionChanged: (selected) {
                      setState(() {
                        _pickerMenuType = selected.single;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  EPhoneField(
                    controller: _pickerDemoController,
                    initialCountry: Country.unitedStates,
                    initialType: EphoneFieldType.phone,
                    countryPicker: CountryPickerConfig(
                      menuType: _pickerMenuType,
                      title:
                          'Select Country (${_pickerLabel(_pickerMenuType)})',
                    ),
                    labels: const EPhoneFieldLabels(
                      empty: 'Phone (picker demo)',
                      phone: 'Phone (picker demo)',
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (_statusMessage != null) Text(_statusMessage!),
            const SizedBox(height: 16),
            FilledButton(onPressed: _submit, child: const Text('Validate')),
            const SizedBox(height: 32),
            Text(
              'Use the segmented control to switch picker presentation, then '
              'open the country button on the second field.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
