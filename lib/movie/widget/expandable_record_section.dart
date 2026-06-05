import 'package:flutter/material.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/labelled_value.dart';

typedef MovieRecord = ({String title, String? subtitle, List<LabelledFact> facts});

class ExpandableRecordSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final String emptyText;
  final List<MovieRecord> records;

  const ExpandableRecordSection({
    super.key,
    required this.title,
    required this.icon,
    required this.emptyText,
    required this.records,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(8);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: radius,
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(title, style: theme.textTheme.titleMedium),
        subtitle: Text('${records.length} entries'),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: RoundedRectangleBorder(borderRadius: radius),
        collapsedShape: RoundedRectangleBorder(borderRadius: radius),
        children: records.isEmpty
            ? [_buildEmptyContent(theme)]
            : records.map((record) => _buildRecordCard(context, record)).toList(),
      ),
    );
  }

  Widget _buildEmptyContent(ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(emptyText, style: theme.textTheme.bodyMedium),
      ),
    );
  }

  Widget _buildRecordCard(BuildContext context, MovieRecord record) {
    final theme = Theme.of(context);
    final subtitle = record.subtitle;

    return Card(
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  foregroundColor: theme.colorScheme.onSurfaceVariant,
                  child: Icon(icon),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(record.title, style: theme.textTheme.titleSmall),
                      if (subtitle != null && subtitle.isNotEmpty) Text(subtitle, style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...record.facts.map(
              (fact) => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: LabelledValue(label: fact.$1, value: fact.$2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
