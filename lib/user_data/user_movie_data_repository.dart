import 'dart:convert';

import 'package:ghibli_movie_gallery_browser/user_data/model/user_movie_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _storageKey = 'user_movie_data';

class UserMovieDataRepository {
  UserMovieDataRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  Future<Map<String, UserMovieData>> getMovieData() async {
    final jsonString = _sharedPreferences.getString(_storageKey);

    if (jsonString == null) {
      return {};
    }

    final json = jsonDecode(jsonString) as Map<String, dynamic>;

    return json.map(
      (movieId, movieDataJson) => MapEntry(movieId, UserMovieData.fromJson(movieDataJson as Map<String, dynamic>)),
    );
  }

  Future<void> setFavorite({required String movieId, required bool isFavorite}) async {
    final movieData = await getMovieData();
    final current = movieData[movieId] ?? const UserMovieData(isFavorite: false, userRating: null);

    movieData[movieId] = UserMovieData(isFavorite: isFavorite, userRating: current.userRating);

    await _save(movieData);
  }

  Future<void> setUserRating({required String movieId, required int? userRating}) async {
    final movieData = await getMovieData();
    final current = movieData[movieId] ?? const UserMovieData(isFavorite: false, userRating: null);

    movieData[movieId] = UserMovieData(isFavorite: current.isFavorite, userRating: userRating);

    await _save(movieData);
  }

  Future<void> _save(Map<String, UserMovieData> movieData) async {
    final json = movieData.map((movieId, movieData) => MapEntry(movieId, movieData.toJson()));
    await _sharedPreferences.setString(_storageKey, jsonEncode(json));
  }
}
