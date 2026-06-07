import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/core/provider/shared_preferences_provider.dart';
import 'package:ghibli_movie_gallery_browser/user_data/repository/user_movie_data_repository.dart';

final userMovieDataRepositoryProvider = Provider<UserMovieDataRepository>((ref) {
  final repository = UserMovieDataRepository(ref.read(sharedPreferencesProvider));
  ref.onDispose(repository.dispose);

  return repository;
});
