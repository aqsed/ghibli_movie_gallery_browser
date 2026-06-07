import 'dart:async';
import 'dart:convert';

import 'package:ghibli_movie_gallery_browser/user_data/model/user_movie_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _storageKey = 'user_movie_data';
const _emptyUserData = UserMovieData(isFavorite: false, userRating: null);

class UserMovieDataRepository {
  UserMovieDataRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;
  final _changes = StreamController<Map<String, UserMovieData>>.broadcast();

  Map<String, UserMovieData>? _cache;

  Stream<Map<String, UserMovieData>> watchUserMovies() async* {
    yield _data;
    yield* _changes.stream;
  }

  Future<void> setFavorite({required String movieId, required bool isFavorite}) {
    return _update(movieId, (current) => UserMovieData(isFavorite: isFavorite, userRating: current.userRating));
  }

  Future<void> setUserRating({required String movieId, required int? userRating}) {
    return _update(movieId, (current) => UserMovieData(isFavorite: current.isFavorite, userRating: userRating));
  }

  void dispose() => _changes.close();

  Future<void> _update(String movieId, UserMovieData Function(UserMovieData current) change) async {
    final previous = _data;
    final next = {...previous, movieId: change(previous[movieId] ?? _emptyUserData)};

    _emit(next);

    try {
      await _persist(next);
    } catch (error) {
      _emit(previous);
      rethrow;
    }
  }

  void _emit(Map<String, UserMovieData> data) {
    _cache = data;
    _changes.add(data);
  }

  Map<String, UserMovieData> get _data => _cache ??= _read();

  Map<String, UserMovieData> _read() {
    final jsonString = _sharedPreferences.getString(_storageKey);

    if (jsonString == null) {
      return {};
    }

    final json = jsonDecode(jsonString) as Map<String, dynamic>;

    return json.map(
      (movieId, movieDataJson) => MapEntry(movieId, UserMovieData.fromJson(movieDataJson as Map<String, dynamic>)),
    );
  }

  Future<void> _persist(Map<String, UserMovieData> data) {
    final json = data.map((movieId, movieData) => MapEntry(movieId, movieData.toJson()));
    return _sharedPreferences.setString(_storageKey, jsonEncode(json));
  }
}
