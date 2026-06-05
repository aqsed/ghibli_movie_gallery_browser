import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_details.dart';
import 'package:ghibli_movie_gallery_browser/movie/provider/movie_repository_provider.dart';
import 'package:ghibli_movie_gallery_browser/movie/provider/movies_notifier.dart';

final movieDetailsProvider = AsyncNotifierProvider.autoDispose.family<MovieDetailsNotifier, MovieDetails, String>(
  MovieDetailsNotifier.new,
);

class MovieDetailsNotifier extends AsyncNotifier<MovieDetails> {
  final String movieId;

  MovieDetailsNotifier(this.movieId);

  @override
  Future<MovieDetails> build() => ref.read(movieRepositoryProvider).getMovieDetails(movieId: movieId);

  Future<void> setFavorite({required bool isFavorite}) async {
    final details = state.requireValue;
    await ref.read(moviesProvider.notifier).setFavorite(movieId: movieId, isFavorite: isFavorite);

    state = AsyncData(details.copyWith(isFavorite: isFavorite, userRating: details.userRating));
  }

  Future<void> setUserRating({required int? userRating}) async {
    final details = state.requireValue;
    await ref.read(moviesProvider.notifier).setUserRating(movieId: movieId, userRating: userRating);

    state = AsyncData(details.copyWith(isFavorite: details.isFavorite, userRating: userRating));
  }
}
