import 'package:ephone_field/src/components/country_card.dart';
import 'package:ephone_field/src/enums/country.dart';
import 'package:flutter/material.dart';

class CountryCardMock extends StatelessWidget {
  const CountryCardMock({Key? key, required this.country}) : super(key: key);
  final Country country;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          child: CountryCard(country: country),
        ),
      ),
    );
  }
}
