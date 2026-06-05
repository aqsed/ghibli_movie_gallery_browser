import 'package:flutter/material.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_gallery_mode.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_list_item.dart';

class GalleryFilterBar extends StatelessWidget {
  final List<MovieListItem> movies;
  final MovieGalleryMode mode;
  final int? ratingFilter;
  final ValueChanged<MovieGalleryMode> onModeChanged;
  final ValueChanged<int?> onRatingFilterChanged;

  const GalleryFilterBar({
    super.key,
    required this.movies,
    required this.mode,
    required this.ratingFilter,
    required this.onModeChanged,
    required this.onRatingFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<MovieGalleryMode>(
          segments: MovieGalleryMode.values
              .map(
                (mode) => ButtonSegment<MovieGalleryMode>(
                  value: mode,
                  icon: Icon(_getIconForMode(mode)),
                  label: Text(
                    '${_getLabelForMode(mode)} ${movies.where((e) => switch (mode) {
                      MovieGalleryMode.all => true,
                      MovieGalleryMode.favorites => e.isFavorite,
                    }).length}',
                  ),
                ),
              )
              .toList(),
          selected: {mode},
          onSelectionChanged: (selection) => onModeChanged(selection.first),
        ),
        const SizedBox(height: 16),
        Text('Filter by your rating', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        SegmentedButton<int?>(
          showSelectedIcon: false,
          segments: [
            const ButtonSegment<int?>(value: null, label: Text('All')),
            ...[5, 4, 3, 2, 1].map((rating) => ButtonSegment<int?>(value: rating, label: Text('$rating'))),
          ],
          selected: {ratingFilter},
          onSelectionChanged: (selection) => onRatingFilterChanged(selection.first),
        ),
      ],
    );
  }

  String _getLabelForMode(MovieGalleryMode mode) => switch (mode) {
    MovieGalleryMode.all => 'All',
    MovieGalleryMode.favorites => 'Favorites',
  };

  IconData _getIconForMode(MovieGalleryMode mode) => switch (mode) {
    MovieGalleryMode.all => Icons.movie_filter_rounded,
    MovieGalleryMode.favorites => Icons.favorite_rounded,
  };
}
