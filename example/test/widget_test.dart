import 'package:ephone_field/ephone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('demo renders the email/phone field', (tester) async {
    await tester.pumpWidget(const EphoneFieldDemoApp());
    expect(find.text('Ephone Field Demo'), findsOneWidget);
    expect(find.byType(EPhoneField), findsNWidgets(2));
    expect(find.text('Validate'), findsOneWidget);
  });
}
