import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_details.dart';
import 'package:ghibli_movie_gallery_browser/movie/provider/movie_repository_provider.dart';

final movieDetailsProvider = StreamProvider.autoDispose.family<MovieDetails, String>(
  (ref, movieId) => ref.watch(movieRepositoryProvider).watchMovieDetails(movieId: movieId),
);
