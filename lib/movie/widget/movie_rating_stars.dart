import 'package:flutter/material.dart';

class MovieRatingStars extends StatelessWidget {
  final int? rating;
  final ValueChanged<int?>? onChanged;
  final double iconSize;
  final MainAxisSize mainAxisSize;

  const MovieRatingStars({
    super.key,
    required this.rating,
    this.onChanged,
    this.iconSize = 22,
    this.mainAxisSize = MainAxisSize.min,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectedRating = rating ?? 0;

    return Row(
      mainAxisSize: mainAxisSize,
      children: List.generate(5, (index) {
        final starRating = index + 1;
        final isSelected = starRating <= selectedRating;

        return IconButton(
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.tightFor(width: iconSize + 8, height: iconSize + 8),
          tooltip: '$starRating star rating',
          onPressed: onChanged == null ? null : () => onChanged!(rating == starRating ? null : starRating),
          icon: Icon(
            isSelected ? Icons.star_rounded : Icons.star_border_rounded,
            size: iconSize,
            color: isSelected ? colorScheme.tertiary : colorScheme.onSurfaceVariant,
          ),
        );
      }),
    );
  }
}
