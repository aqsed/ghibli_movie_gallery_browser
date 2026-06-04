import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/core/provider/shared_preferences_provider.dart';
import 'package:ghibli_movie_gallery_browser/user_data/user_movie_data_repository.dart';

final userMovieDataRepositoryProvider = Provider<UserMovieDataRepository>(
  (ref) => UserMovieDataRepository(ref.read(sharedPreferencesProvider)),
);
