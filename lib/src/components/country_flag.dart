import 'package:flutter/material.dart';

import '../enums/country.dart';

/// Renders a country flag image with emoji fallback.
class CountryFlag extends StatelessWidget {
  /// Creates a country flag widget.
  const CountryFlag({
    super.key,
    required this.country,
    this.size = 20,
    this.useImage = true,
  });

  /// Country whose flag is shown.
  final Country country;

  /// Width and height of the flag.
  final double size;

  /// When false, renders [Country.flagEmoji] only (no asset load).
  final bool useImage;

  @override
  Widget build(BuildContext context) {
    if (!useImage) {
      return _emojiFlag();
    }

    return Image.asset(
      country.flagImagePath,
      package: 'ephone_field',
      width: size,
      height: size * 0.75,
      cacheWidth: (size * MediaQuery.devicePixelRatioOf(context)).round(),
      filterQuality: FilterQuality.medium,
      errorBuilder: (context, error, stackTrace) => _emojiFlag(),
    );
  }

  Widget _emojiFlag() {
    return SizedBox(
      width: size,
      child: Text(
        country.flagEmoji,
        style: TextStyle(fontSize: size * 0.8),
        textAlign: TextAlign.center,
      ),
    );
  }
}
