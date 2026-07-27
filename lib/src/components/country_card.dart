import 'package:flutter/material.dart';

import '../enums/country.dart';
import 'country_flag.dart';

/// List row for a single country in the picker.
class CountryCard extends StatelessWidget {
  /// Creates a country list row.
  const CountryCard({
    super.key,
    required this.country,
    this.isSelected = false,
  });

  /// Country displayed in the row.
  final Country country;

  /// Whether this country is currently selected.
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.bodyLarge;
    final subtitleStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final dialStyle = theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
    );

    return ListTile(
      leading: CountryFlag(country: country, size: 32),
      title: Text(country.name, style: titleStyle),
      subtitle: Text(country.alpha3, style: subtitleStyle),
      trailing: SizedBox(
        width: 88,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('+${country.dialCode}', style: dialStyle),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.check,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
