import 'package:ephone_field/ephone_field.dart';
import 'package:ephone_field/src/components/components.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/country_picker_button.dart';

void main() {
  const CountryPickerButtonMock mockWidget = CountryPickerButtonMock(menuType: PickerMenuType.bottomSheet);
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
}
