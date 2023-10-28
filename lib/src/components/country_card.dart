import 'package:flutter/material.dart';

import '../enums/country.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({Key? key, required this.country}) : super(key: key);
  final Country country;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        country.flagImagePath,
        package: 'ephone_field',
        width: 32.0,
      ),
      title: Text(country.name),
      subtitle: Text(country.alpha3),
      trailing: Text('+${country.dialCode}',
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
    );
  }
}
