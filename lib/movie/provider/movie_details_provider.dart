import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_details.dart';
import 'package:ghibli_movie_gallery_browser/movie/provider/movie_repository_provider.dart';

// currently movie details won't have mutations, if it has then change this to notifier
final movieDetailsProvider = FutureProvider.family<MovieDetails, String>((ref, movieId) {
  return ref.read(movieRepositoryProvider).getMovieDetails(movieId: movieId);
});
