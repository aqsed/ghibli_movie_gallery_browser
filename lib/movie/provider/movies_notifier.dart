import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_list_item.dart';
import 'package:ghibli_movie_gallery_browser/movie/provider/movie_repository_provider.dart';

final moviesProvider = AsyncNotifierProvider<MoviesNotifier, List<MovieListItem>>(MoviesNotifier.new);

class MoviesNotifier extends AsyncNotifier<List<MovieListItem>> {
  @override
  Future<List<MovieListItem>> build() => ref.read(movieRepositoryProvider).getMovies();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(movieRepositoryProvider).getMovies());
  }

  Future<void> setFavorite({required String movieId, required bool isFavorite}) async {
    await ref.read(movieRepositoryProvider).setFavorite(movieId: movieId, isFavorite: isFavorite);

    _replaceUserData(movieId, (movie) => movie.withUserData(isFavorite: isFavorite, userRating: movie.userRating));
  }

  Future<void> setUserRating({required String movieId, required int? userRating}) async {
    await ref.read(movieRepositoryProvider).setUserRating(movieId: movieId, userRating: userRating);

    _replaceUserData(movieId, (movie) => movie.withUserData(isFavorite: movie.isFavorite, userRating: userRating));
  }

  void _replaceUserData(String movieId, MovieListItem Function(MovieListItem movie) update) {
    final currentMovies = state.value;

    if (currentMovies == null) {
      return;
    }

    state = AsyncData(currentMovies.map((movie) => movie.id == movieId ? update(movie) : movie).toList());
  }
}
