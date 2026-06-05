import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final ValueChanged<bool> onChanged;

  const FavoriteButton({super.key, required this.isFavorite, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
      onPressed: () => onChanged(!isFavorite),
      icon: Icon(isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: Colors.redAccent),
    );
  }
}
