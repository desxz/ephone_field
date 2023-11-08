import 'dart:async';

import 'package:ephone_field/src/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/country_picker.dart';

void main() {
  final Completer<void> completer = Completer<void>();
  final CountryPickerMock mockWidget = CountryPickerMock(onValuePicked: completer.complete);

  testWidgets('should CountryPickerMenu widget renders successfully', (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    expect(find.byType(CountryPicker), findsOneWidget);
  });

  testWidgets('should CountryPickerMenu widget renders successfully with search input', (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    expect(find.byKey(const Key("search-field")), findsOneWidget);
  });

  testWidgets('should CountryPickerMenu widget renders successfully with country picker list', (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    expect(find.byKey(const Key("country-picker-list")), findsOneWidget);
  });

  testWidgets('should CountryPickerMenu widget renders successfully with country card widget', (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    expect(find.byType(CountryCard), findsWidgets);
  });

  testWidgets('should CountryPickerMenu widget renders searched countries by name', (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    await widgetTester.enterText(find.byKey(const Key("search-field")), "United States");
    await widgetTester.pump();
    expect(find.byKey(const Key("country-picker-list")), findsOneWidget);
    expect(find.text("United States"), findsWidgets);
    expect(find.byType(CountryCard), findsWidgets);
  });

  testWidgets('should CountryPickerMenu widget renders searched countries by code', (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    await widgetTester.enterText(find.byKey(const Key("search-field")), "90");
    await widgetTester.pump();
    expect(find.byKey(const Key("country-picker-list")), findsOneWidget);
    expect(find.text("Turkey"), findsWidgets);
    expect(find.byType(CountryCard), findsWidgets);
  });

  testWidgets('should CountryPickerMenu onValuePicked triggered after selected country', (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    await widgetTester.enterText(find.byKey(const Key("search-field")), "90");
    await widgetTester.pump();
    expect(find.byKey(const Key("country-picker-list")), findsOneWidget);
    expect(find.text("Turkey"), findsWidgets);
    expect(find.byType(CountryCard), findsWidgets);
    await widgetTester.tap(find.text("Turkey"));
    expect(completer.isCompleted, isTrue);
  });
}
