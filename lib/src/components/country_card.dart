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
    this.useFlagImages = true,
  });

  /// Country displayed in the row.
  final Country country;

  /// Whether this country is currently selected.
  final bool isSelected;

  /// Whether to load PNG flag assets (vs emoji).
  final bool useFlagImages;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final titleStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
    );
    final subtitleStyle = theme.textTheme.bodySmall?.copyWith(
      color: scheme.onSurfaceVariant,
    );
    final dialStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: scheme.onSurface,
    );

    return Material(
      color: isSelected
          ? scheme.primaryContainer.withValues(alpha: 0.35)
          : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: Row(
          children: [
            CountryFlag(
              country: country,
              size: 28,
              useImage: useFlagImages,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(country.name, style: titleStyle, maxLines: 1),
                  Text(country.alpha2, style: subtitleStyle),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text('+${country.dialCode}', style: dialStyle),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Icon(Icons.check, color: scheme.primary, size: 18),
            ],
          ],
        ),
      ),
    );
  }
}
