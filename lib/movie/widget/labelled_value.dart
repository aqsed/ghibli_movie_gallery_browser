import 'package:flutter/material.dart';

typedef LabelledFact = (String label, String value);

class LabelledValue extends StatelessWidget {
  final String label;
  final String value;

  const LabelledValue({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.primary)),
        const SizedBox(height: 3),
        SelectableText(
          value.isEmpty ? '-' : value,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
