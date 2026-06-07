import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_list_item.dart';
import 'package:ghibli_movie_gallery_browser/movie/provider/movie_repository_provider.dart';

final moviesProvider = StreamProvider<List<MovieListItem>>(
  (ref) => ref.watch(movieRepositoryProvider).watchMovies(),
);
