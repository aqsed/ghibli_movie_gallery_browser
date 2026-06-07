import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_gallery_mode.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_list_item.dart';
import 'package:ghibli_movie_gallery_browser/movie/page/movie_detail_page.dart';
import 'package:ghibli_movie_gallery_browser/movie/provider/movie_repository_provider.dart';
import 'package:ghibli_movie_gallery_browser/movie/provider/movies_provider.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/movie_error_view.dart';
import 'package:ghibli_movie_gallery_browser/movie/widget/movie_gallery.dart';

class MovieBrowsingPage extends ConsumerStatefulWidget {
  const MovieBrowsingPage({super.key});

  @override
  ConsumerState<MovieBrowsingPage> createState() => _MovieBrowsingPageState();
}

class _MovieBrowsingPageState extends ConsumerState<MovieBrowsingPage> {
  var _mode = MovieGalleryMode.all;

  int? _ratingFilter;

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(moviesProvider);

    return Scaffold(
      body: SafeArea(
        child: movies.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) {
            return MovieErrorView(error: error, onRetry: () => ref.invalidate(moviesProvider));
          },
          data: (movies) => MovieGallery(
            movies: movies,
            mode: _mode,
            ratingFilter: _ratingFilter,
            onModeChanged: (mode) => setState(() => _mode = mode),
            onRatingFilterChanged: (rating) => setState(() => _ratingFilter = rating),
            onMovieOpen: _openMovie,
            onFavoriteChanged: _setFavorite,
            onRatingChanged: _setUserRating,
          ),
        ),
      ),
    );
  }

  void _openMovie(MovieListItem movie) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => MovieDetailPage(movieId: movie.id)));
  }

  Future<void> _setFavorite(MovieListItem movie, bool isFavorite) {
    return ref.read(movieRepositoryProvider).setFavorite(movieId: movie.id, isFavorite: isFavorite);
  }

  Future<void> _setUserRating(MovieListItem movie, int? userRating) {
    return ref.read(movieRepositoryProvider).setUserRating(movieId: movie.id, userRating: userRating);
  }
}
