import 'package:flutter/material.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_list_item.dart';
import 'package:ghibli_movie_gallery_browser/movie/util/movie_format.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/favorite_button.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/movie_rating_stars.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/rotten_tomatoes_score_container.dart';

class MovieCard extends StatelessWidget {
  final MovieListItem movie;
  final VoidCallback onOpen;
  final ValueChanged<bool> onFavoriteChanged;
  final ValueChanged<int?> onRatingChanged;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onOpen,
    required this.onFavoriteChanged,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildMovieHeaderImage(context),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withValues(alpha: 0.08), Colors.black.withValues(alpha: 0.58)],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: FavoriteButton(isFavorite: movie.isFavorite, onChanged: onFavoriteChanged),
                  ),
                  Positioned(
                    left: 14,
                    right: 14,
                    bottom: 14,
                    child: Text(
                      movie.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        shadows: const [Shadow(offset: Offset(0, 1), blurRadius: 8)],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            _buildDescriptionAndRatingSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionAndRatingSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_getMetaLine(movie), style: theme.textTheme.labelLarge?.copyWith(color: colorScheme.primary)),
          if (movie.rottenTomatoesRating.isNotEmpty) ...[
            const SizedBox(height: 8),
            RottenTomatoesScoreContainer(score: movie.rottenTomatoesRating),
          ],
          const SizedBox(height: 10),
          Text(
            movie.description,
            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text('Your rating', style: theme.textTheme.labelMedium),
              const Spacer(),
              MovieRatingStars(rating: movie.userRating, onChanged: onRatingChanged),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMovieHeaderImage(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Hero(
      tag: 'movie-image-${movie.id}',
      child: Image.network(
        movie.image,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => ColoredBox(
          color: colorScheme.surfaceContainerHighest,
          child: Icon(Icons.movie_rounded, size: 42, color: colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }

  String _getMetaLine(MovieListItem movie) {
    if (movie.runningTime.isEmpty) {
      return movie.releaseDate;
    }

    return '${movie.releaseDate}  ·  ${formatRunningTime(movie.runningTime)}';
  }
}
