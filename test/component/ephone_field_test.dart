import 'package:ephone_field/src/components/country_picker_button.dart';
import 'package:ephone_field/src/email_phone_textfield.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/email_phone_textfield.dart';

void main() {
  const EPhoneFieldMock ePhoneFieldMock = EPhoneFieldMock();

  testWidgets('should EPhoneFieldMock widget renders successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(ePhoneFieldMock);
    expect(find.byType(EPhoneFieldMock), findsOneWidget);
  });

  testWidgets('should EPhoneField widget renders successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(ePhoneFieldMock);
    expect(find.byType(EPhoneField), findsOneWidget);
  });

  testWidgets('should EPhoneField widget renders correct hint text',
      (WidgetTester tester) async {
    await tester.pumpWidget(ePhoneFieldMock);

    expect(find.text('Email or phone number'), findsWidgets);
  });

  testWidgets('should EPhoneField widget change type to email when enter @',
      (WidgetTester tester) async {
    await tester.pumpWidget(ePhoneFieldMock);

    final Finder textField = find.byType(EPhoneField);
    await tester.enterText(textField, '@');
    await tester.pump();

    expect(find.text('@'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.byType(CountryPickerButton), findsNothing);
  });

  testWidgets('should EPhoneField widget change type to phone when enter +',
      (WidgetTester tester) async {
    await tester.pumpWidget(ePhoneFieldMock);

    final Finder textField = find.byType(EPhoneField);
    await tester.enterText(textField, '1');
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);
    expect(find.byType(CountryPickerButton), findsOneWidget);
  });
}
