import 'package:ephone_field/src/components/components.dart';
import 'package:ephone_field/src/email_phone_textfield.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/email_phone_textfield.dart';
import 'utils/caller_checker.dart';

void main() {
  const EPhoneFieldMock ePhoneFieldMock = EPhoneFieldMock(
    emailValidator: EphoneFieldCallerChecker.mockEmailValidator,
    phoneValidator: EphoneFieldCallerChecker.mockPhoneValidator,
    onChanged: EphoneFieldCallerChecker.mockOnChanged,
    onCountryChanged: EphoneFieldCallerChecker.mockOnCountryChanged,
  );

  setUp(() {
    EphoneFieldCallerChecker.reset();
  });

  testWidgets('should EPhoneFieldMock widget renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(ePhoneFieldMock);
    expect(find.byType(EPhoneFieldMock), findsOneWidget);
  });

  testWidgets('should EPhoneField widget renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(ePhoneFieldMock);
    expect(find.byType(EPhoneField), findsOneWidget);
  });

  testWidgets('should EPhoneField widget renders correct hint text', (WidgetTester tester) async {
    await tester.pumpWidget(ePhoneFieldMock);

    expect(find.text('Email or phone number'), findsWidgets);
  });

  testWidgets('should EPhoneField widget change type to email when enter @', (WidgetTester tester) async {
    await tester.pumpWidget(ePhoneFieldMock);

    final Finder textField = find.byType(EPhoneField);
    await tester.enterText(textField, '@');
    await tester.pump();

    expect(find.text('@'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.byType(CountryPickerButton), findsNothing);
  });

  testWidgets('should EPhoneField widget change type to phone when enter +', (WidgetTester tester) async {
    await tester.pumpWidget(ePhoneFieldMock);

    final Finder textField = find.byType(EPhoneField);
    await tester.enterText(textField, '1');
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);
    expect(find.byType(CountryPickerButton), findsOneWidget);
  });

  testWidgets('should email validator called  when validate while type email', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(ePhoneFieldMock);

    final Finder textField = find.byType(EPhoneField);
    await widgetTester.enterText(textField, '@');
    await widgetTester.pump();

    expect(find.text('@'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.byType(CountryPickerButton), findsNothing);

    await widgetTester.pump();

    expect(EphoneFieldCallerChecker.isEmailValidatorCalled, true);
    expect(EphoneFieldCallerChecker.isPhoneValidatorCalled, false);
  });

  testWidgets('should phone validator called  when validate while type phone', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(ePhoneFieldMock);

    final Finder textField = find.byType(EPhoneField);
    await widgetTester.enterText(textField, '1');
    await widgetTester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);
    expect(find.byType(CountryPickerButton), findsOneWidget);

    await widgetTester.pump();

    expect(EphoneFieldCallerChecker.isEmailValidatorCalled, false);
    expect(EphoneFieldCallerChecker.isPhoneValidatorCalled, true);
  });

  testWidgets('should onChanged called when type email', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(ePhoneFieldMock);

    final Finder textField = find.byType(EPhoneField);
    await widgetTester.enterText(textField, '@');
    await widgetTester.pump();

    expect(find.text('@'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.byType(CountryPickerButton), findsNothing);

    expect(EphoneFieldCallerChecker.isOnChangedCalled, true);
  });

  testWidgets('should onChanged called when type phone', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(ePhoneFieldMock);

    final Finder textField = find.byType(EPhoneField);
    await widgetTester.enterText(textField, '1');
    await widgetTester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);
    expect(find.byType(CountryPickerButton), findsOneWidget);

    expect(EphoneFieldCallerChecker.isOnChangedCalled, true);
  });

  testWidgets('should onCountryChanged called when select country', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(ePhoneFieldMock);

    final Finder textField = find.byType(EPhoneField);
    await widgetTester.enterText(textField, '1');
    await widgetTester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);
    expect(find.byType(CountryPickerButton), findsOneWidget);

    await widgetTester.tap(find.byType(CountryPickerButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsOneWidget);

    await widgetTester.tap(find.text("Afghanistan"));
    await widgetTester.pumpAndSettle();

    expect(EphoneFieldCallerChecker.isOnCountryChangedCalled, true);
  });
}
