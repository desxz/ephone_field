import 'package:ephone_field/ephone_field.dart';
import 'package:ephone_field/src/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/country_picker_button.dart';
import 'utils/caller_checker.dart';

void main() {
  CountryPickerButtonMock mockWidget =
      CountryPickerButtonMock(menuType: PickerMenuType.bottomSheet, pickerHeight: CountryPickerHeigth.h25);

  setUp(() {
    EphoneFieldCallerChecker.reset();
  });
  testWidgets('should CountryPickerButton widget renders successfully', (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    expect(find.byType(CountryPickerButton), findsOneWidget);
  });

  testWidgets('should CountryPickerButton widget renders correct dialCode', (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    expect(find.text("+${mockWidget.initialValue.dialCode}"), findsOneWidget);
  });

  testWidgets('should CountryPickerButton widget renders correct icon', (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);

    expect(find.byIcon(mockWidget.icon), findsOneWidget);
  });

  testWidgets('should CountryPickerButton widget renders correct image', (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('should CountryPickerButton widget renders CountryPickerMenu on tap', (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);

    await widgetTester.tap(find.byType(CountryPickerButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsOneWidget);
  });

  testWidgets('should CountryPickerButton widget renders CountryPickerMenu as bottomsheet on tap',
      (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);

    await widgetTester.tap(find.byType(CountryPickerButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsOneWidget);
    expect(find.byType(BottomSheet), findsOneWidget);
  });

  testWidgets('should CountryPickerButton widget renders CountryPickerMenu as page on tap', (widgetTester) async {
    mockWidget = CountryPickerButtonMock(menuType: PickerMenuType.page, pickerHeight: CountryPickerHeigth.h25);
    await widgetTester.pumpWidget(mockWidget);

    await widgetTester.tap(find.byType(CountryPickerButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('should CountryPickerButton widget renders CountryPickerMenu as dialog on tap', (widgetTester) async {
    mockWidget = CountryPickerButtonMock(menuType: PickerMenuType.dialog, pickerHeight: CountryPickerHeigth.h25);
    await widgetTester.pumpWidget(mockWidget);

    await widgetTester.tap(find.byType(CountryPickerButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsOneWidget);
    expect(find.byType(Dialog), findsOneWidget);
  });

  testWidgets('should CountryPickerButton widget onValuePicked triggers after selecting country on dialog',
      (widgetTester) async {
    mockWidget = CountryPickerButtonMock(menuType: PickerMenuType.dialog, pickerHeight: CountryPickerHeigth.h25);
    await widgetTester.pumpWidget(mockWidget);

    await widgetTester.tap(find.byType(CountryPickerButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsOneWidget);
    expect(find.byType(Dialog), findsOneWidget);

    await widgetTester.tap(find.byType(CountryCard).first);
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsNothing);
    expect(find.byType(Dialog), findsNothing);

    expect(EphoneFieldCallerChecker.isOnValuePickedCalled, true);
  });

  testWidgets('should CountryPickerButton widget onValuePicked triggers after selecting country on bottomsheet',
      (widgetTester) async {
    mockWidget = CountryPickerButtonMock(menuType: PickerMenuType.bottomSheet, pickerHeight: CountryPickerHeigth.h25);
    await widgetTester.pumpWidget(mockWidget);

    await widgetTester.tap(find.byType(CountryPickerButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsOneWidget);
    expect(find.byType(BottomSheet), findsOneWidget);

    await widgetTester.tap(find.byType(CountryCard).first);
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsNothing);
    expect(find.byType(BottomSheet), findsNothing);

    expect(EphoneFieldCallerChecker.isOnValuePickedCalled, true);
  });

  testWidgets('should CountryPickerButton widget onValuePicked triggers after selecting country on page',
      (widgetTester) async {
    mockWidget = CountryPickerButtonMock(menuType: PickerMenuType.page, pickerHeight: CountryPickerHeigth.h25);
    await widgetTester.pumpWidget(mockWidget);

    await widgetTester.tap(find.byType(CountryPickerButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);

    await widgetTester.tap(find.byType(CountryCard).first);
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsNothing);

    expect(EphoneFieldCallerChecker.isOnValuePickedCalled, true);
  });

  testWidgets('should country picker size as expected if pickerHeight CountryPickerHeigth.h25', (widgetTester) async {
    mockWidget = CountryPickerButtonMock(menuType: PickerMenuType.bottomSheet, pickerHeight: CountryPickerHeigth.h25);
    await widgetTester.pumpWidget(mockWidget);

    await widgetTester.tap(find.byType(CountryPickerButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsOneWidget);

    final CountryPickerMenu menu = widgetTester.firstWidget(find.byType(CountryPickerMenu));
    expect(
      menu.height,
      mockWidget.ctx!.size!.height * .25,
    );
  });

  testWidgets('should country picker size as expected if pickerHeight CountryPickerHeigth.h50', (widgetTester) async {
    mockWidget = CountryPickerButtonMock(menuType: PickerMenuType.bottomSheet, pickerHeight: CountryPickerHeigth.h50);
    await widgetTester.pumpWidget(mockWidget);

    await widgetTester.tap(find.byType(CountryPickerButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsOneWidget);

    final CountryPickerMenu menu = widgetTester.firstWidget(find.byType(CountryPickerMenu));
    expect(
      menu.height,
      mockWidget.ctx!.size!.height * .50,
    );
  });

  testWidgets('should country picker size as expected if pickerHeight CountryPickerHeigth.h75', (widgetTester) async {
    mockWidget = CountryPickerButtonMock(menuType: PickerMenuType.bottomSheet, pickerHeight: CountryPickerHeigth.h75);
    await widgetTester.pumpWidget(mockWidget);

    await widgetTester.tap(find.byType(CountryPickerButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsOneWidget);

    final CountryPickerMenu menu = widgetTester.firstWidget(find.byType(CountryPickerMenu));
    expect(
      menu.height,
      mockWidget.ctx!.size!.height * .75,
    );
  });

  testWidgets('should country picker size as expected if pickerHeight CountryPickerHeigth.h100', (widgetTester) async {
    mockWidget = CountryPickerButtonMock(menuType: PickerMenuType.bottomSheet, pickerHeight: CountryPickerHeigth.h100);
    await widgetTester.pumpWidget(mockWidget);

    await widgetTester.tap(find.byType(CountryPickerButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(CountryPickerMenu), findsOneWidget);

    final CountryPickerMenu menu = widgetTester.firstWidget(find.byType(CountryPickerMenu));
    expect(
      menu.height,
      mockWidget.ctx!.size!.height,
    );
  });
}
