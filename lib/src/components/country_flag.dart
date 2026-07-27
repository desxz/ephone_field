import 'package:flutter/material.dart';

import '../enums/country.dart';

/// Renders a country flag image with emoji fallback.
class CountryFlag extends StatelessWidget {
  /// Creates a country flag widget.
  const CountryFlag({
    super.key,
    required this.country,
    this.size = 20,
  });

  /// Country whose flag is shown.
  final Country country;

  /// Width and height of the flag.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      country.flagImagePath,
      package: 'ephone_field',
      width: size,
      height: size * 0.75,
      cacheWidth: (size * MediaQuery.devicePixelRatioOf(context)).round(),
      filterQuality: FilterQuality.medium,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: size,
          child: Text(
            country.flagEmoji,
            style: TextStyle(fontSize: size * 0.8),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
