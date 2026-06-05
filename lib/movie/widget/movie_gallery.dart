import 'package:flutter/material.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_gallery_mode.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_list_item.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/gallery_filter_bar.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/movie_card.dart';

class MovieGallery extends StatelessWidget {
  final List<MovieListItem> movies;
  final MovieGalleryMode mode;
  final int? ratingFilter;

  final ValueChanged<MovieGalleryMode> onModeChanged;
  final ValueChanged<int?> onRatingFilterChanged;
  final ValueChanged<MovieListItem> onMovieOpen;
  final void Function(MovieListItem movie, bool isFavorite) onFavoriteChanged;
  final void Function(MovieListItem movie, int? userRating) onRatingChanged;

  const MovieGallery({
    super.key,
    required this.movies,
    required this.mode,
    required this.ratingFilter,
    required this.onModeChanged,
    required this.onRatingFilterChanged,
    required this.onMovieOpen,
    required this.onFavoriteChanged,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleMovies = movies.where(_matchesFilters).toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: _buildMovieGalleryHeader(context),
              ),
            ),
          ),
        ),
        if (visibleMovies.isEmpty)
          SliverFillRemaining(hasScrollBody: false, child: _buildEmptyState(theme))
        else
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: LayoutBuilder(
                    builder: (context, constraints) =>
                        _buildMovieCardsLayout(movies, _cardWidthFor(constraints.maxWidth)),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMovieGalleryHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Studio Ghibli Gallery', style: theme.textTheme.displaySmall),
        const SizedBox(height: 6),
        Text(
          'A calm film gallery with your favorites and personal ratings close at hand.',
          style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 20),
        GalleryFilterBar(
          movies: movies,
          mode: mode,
          ratingFilter: ratingFilter,
          onModeChanged: onModeChanged,
          onRatingFilterChanged: onRatingFilterChanged,
        ),
      ],
    );
  }

  Widget _buildMovieCardsLayout(List<MovieListItem> movies, double cardWidth) {
    return Wrap(
      spacing: 18,
      runSpacing: 18,
      children: movies
          .map(
            (movie) => SizedBox(
              width: cardWidth,
              child: MovieCard(
                movie: movie,
                onOpen: () => onMovieOpen(movie),
                onFavoriteChanged: (isFavorite) => onFavoriteChanged(movie, isFavorite),
                onRatingChanged: (rating) => onRatingChanged(movie, rating),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    final message = mode == MovieGalleryMode.favorites
        ? 'No favorites match this filter yet.'
        : 'No movies match this filter yet.';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.filter_alt_off_rounded, size: 42, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(message, style: theme.textTheme.titleMedium, textAlign: TextAlign.center),
            if (ratingFilter != null) ...[
              const SizedBox(height: 6),
              Text(
                'Try another star rating.',
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool _matchesFilters(MovieListItem movie) {
    final matchesRating = ratingFilter == null || movie.userRating == ratingFilter;

    final matchesFilterMode = switch (mode) {
      MovieGalleryMode.all => true,
      MovieGalleryMode.favorites => movie.isFavorite,
    };

    return matchesRating && matchesFilterMode;
  }

  double _cardWidthFor(double availableWidth) {
    if (availableWidth < 620) {
      return availableWidth;
    }

    if (availableWidth < 940) {
      return (availableWidth - 18) / 2;
    }

    return (availableWidth - 36) / 3;
  }
}
