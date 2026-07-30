import 'package:ephone_field/ephone_field.dart';
import 'package:ephone_field/src/infrastructure/phone/stub/unsupported_phone_number_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fake_phone_number_service.dart';

void main() {
  group('EPhoneField phone formatting', () {
    testWidgets('keeps multiple digits when as-you-type is unavailable',
        (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EPhoneField(
              controller: controller,
              debugPhoneNumberService: const UnsupportedPhoneNumberService(),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), '1');
      await tester.pump();
      await tester.enterText(find.byType(TextFormField), '12');
      await tester.pump();

      expect(controller.text, '12');
    });

    testWidgets('uses as-you-type formatter when service supports it',
        (tester) async {
      final service = FakePhoneNumberService();
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EPhoneField(
              controller: controller,
              debugPhoneNumberService: service,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), '4');
      await tester.pump();
      await tester.enterText(find.byType(TextFormField), '41');
      await tester.pump();

      expect(controller.text, '41');
      expect(service.createdSessions, isNotEmpty);
    });

    testWidgets('falls back to length and digits-only when AsYouType is off',
        (tester) async {
      final service = FakePhoneNumberService(
        supportsAsYouTypeFormatting: false,
      );
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EPhoneField(
              controller: controller,
              debugPhoneNumberService: service,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), '4');
      await tester.pump();
      await tester.enterText(find.byType(TextFormField), '41');
      await tester.pump();

      expect(controller.text, '41');
      expect(service.createdSessions, isEmpty);
    });
  });
}
