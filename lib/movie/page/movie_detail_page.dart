import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/movie/provider/movie_details_provider.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/movie_details_content.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/movie_error_view.dart';

class MovieDetailPage extends ConsumerWidget {
  final String movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetails = ref.watch(movieDetailsProvider(movieId));
    final notifier = ref.read(movieDetailsProvider(movieId).notifier);

    return Scaffold(
      body: movieDetails.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => MovieErrorView(
          title: 'Could not load movie detail',
          error: error,
          onRetry: () => ref.invalidate(movieDetailsProvider(movieId)),
        ),
        data: (details) => MovieDetailsContent(
          details: details,
          onFavoriteChanged: (isFavorite) => notifier.setFavorite(isFavorite: isFavorite),
          onRatingChanged: (rating) => notifier.setUserRating(userRating: rating),
        ),
      ),
    );
  }
}
