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
    final movies = state.requireValue;

    state = AsyncData(
      movies.map((movie) => movie.id == movieId ? movie.copyWith(isFavorite: isFavorite) : movie).toList(),
    );
  }

  Future<void> setUserRating({required String movieId, required int? userRating}) async {
    await ref.read(movieRepositoryProvider).setUserRating(movieId: movieId, userRating: userRating);
    final movies = state.requireValue;

    state = AsyncData(
      movies.map((movie) => movie.id == movieId ? movie.copyWith(userRating: userRating) : movie).toList(),
    );
  }
}
