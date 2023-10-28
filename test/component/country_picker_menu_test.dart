import 'package:ephone_field/src/components/country_card.dart';
import 'package:ephone_field/src/components/country_picker_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/country_picker_menu.dart';

void main() {
  final CountryPickerMenuMock mockWidget = CountryPickerMenuMock();

  testWidgets('should CountryPickerMenu widget renders successfully',
      (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    expect(find.byType(CountryPickerMenu), findsOneWidget);
  });

  testWidgets('should CountryPickerMenu widget renders correct title',
      (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    widgetTester.firstWidget(find.byType(CountryPickerMenu));

    expect(find.text(mockWidget.title), findsOneWidget);
  });

  testWidgets('should CountryPickerMenu widget renders correct search field',
      (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    widgetTester.firstWidget(find.byType(CountryPickerMenu));

    expect(find.byType(TextField), findsOneWidget);
    expect(
        find.text(mockWidget.searchInputDecoration.hintText!), findsOneWidget);
  });

  testWidgets('should CountryPickerMenu widget renders correct country list',
      (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    widgetTester.firstWidget(find.byType(CountryPickerMenu));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('should CountryPickerMenu widget renders correct country card',
      (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    widgetTester.firstWidget(find.byType(CountryPickerMenu));

    expect(find.byType(CountryCard), findsWidgets);
  });
}
