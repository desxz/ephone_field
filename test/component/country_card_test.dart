import 'package:ephone_field/src/components/country_card.dart';
import 'package:ephone_field/src/enums/enums.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/country_card.dart';

void main() {
  const Country country = Country.unitedStates;
  const Widget mockWidget = CountryCardMock(country: country);

  testWidgets('should CountryCard widget renders successfully',
      (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);
    expect(find.byType(CountryCard), findsOneWidget);
  });

  testWidgets('should CountryCard widget renders correct title',
      (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);

    expect(find.text(country.name), findsOneWidget);
  });

  testWidgets('should CountryCard widget renders correct subtitle',
      (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);

    expect(find.text(country.alpha3), findsOneWidget);
  });

  testWidgets('should CountryCard widget renders correct dial code',
      (widgetTester) async {
    await widgetTester.pumpWidget(mockWidget);

    expect(find.text('+${country.dialCode}'), findsOneWidget);
  });
}
