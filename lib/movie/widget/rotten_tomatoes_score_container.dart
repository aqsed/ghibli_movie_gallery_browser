import 'package:flutter/material.dart';

class RottenTomatoesScoreContainer extends StatelessWidget {
  final String score;

  const RottenTomatoesScoreContainer({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: 'Rotten Tomatoes score',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0xFFF3C5C0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🍅', style: TextStyle(fontSize: 15)),
            const SizedBox(width: 6),
            Text(
              '$score%',
              style: theme.textTheme.labelLarge?.copyWith(color: const Color(0xFFC62828), fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
