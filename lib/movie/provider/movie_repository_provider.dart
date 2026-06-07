import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/movie/provider/ghibli_api_connector_provider.dart';
import 'package:ghibli_movie_gallery_browser/movie/repository/movie_repository.dart';
import 'package:ghibli_movie_gallery_browser/user_data/provider/user_movie_data_repository_provider.dart';

final movieRepositoryProvider = Provider<MovieRepository>(
  (ref) => MovieRepository(
    ref.read(ghibliApiConnectorProvider),
    ref.read(userMovieDataRepositoryProvider),
  ),
);
