import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_list_item.dart';
import 'package:ghibli_movie_gallery_browser/movie/provider/movie_details_provider.dart';
import 'package:ghibli_movie_gallery_browser/movie/provider/movie_repository_provider.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/movie_details_content.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/movie_error_view.dart';

class MovieDetailPage extends ConsumerWidget {
  final MovieListItem movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetails = ref.watch(movieDetailsProvider(movie.id));
    final repository = ref.read(movieRepositoryProvider);

    return Scaffold(
      body: movieDetails.when(
        loading: () => MovieDetailsContent(
          movie: movie,
          details: null,
          onFavoriteChanged: (isFavorite) => repository.setFavorite(movieId: movie.id, isFavorite: isFavorite),
          onRatingChanged: (rating) => repository.setUserRating(movieId: movie.id, userRating: rating),
        ),
        error: (error, stackTrace) => MovieErrorView(
          title: 'Could not load movie detail',
          error: error,
          onRetry: () => ref.invalidate(movieDetailsProvider(movie.id)),
        ),
        data: (details) => MovieDetailsContent(
          movie: movie,
          details: details,
          onFavoriteChanged: (isFavorite) => repository.setFavorite(movieId: movie.id, isFavorite: isFavorite),
          onRatingChanged: (rating) => repository.setUserRating(movieId: movie.id, userRating: rating),
        ),
      ),
    );
  }
}
