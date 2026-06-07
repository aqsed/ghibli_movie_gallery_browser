import 'package:ghibli_movie_gallery_browser/movie/api/ghibli_api_connector.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/movie_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_details.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_list_item.dart';
import 'package:ghibli_movie_gallery_browser/user_data/model/user_movie_data.dart';
import 'package:ghibli_movie_gallery_browser/user_data/repository/user_movie_data_repository.dart';

class MovieRepository {
  final GhibliApiConnector _apiConnector;
  final UserMovieDataRepository _userDataRepository;

  const MovieRepository(this._apiConnector, this._userDataRepository);

  Stream<List<MovieListItem>> watchMovies() async* {
    final movies = await _apiConnector.getMovies();

    yield* _userDataRepository.watchUserMovies().map(
      (userData) => movies.map((movie) => _buildMovieListItem(movie, userData[movie.id])).toList(),
    );
  }

  Stream<MovieDetails> watchMovieDetails({required String movieId}) async* {
    final movie = await _apiConnector.getMovie(movieId: movieId);

    final (people, species, locations, vehicles) = await (
      Future.wait(_getFilteredRelevantDetailsUrls(movie.peopleUrls).map((url) => _apiConnector.getPerson(url: url))),
      Future.wait(_getFilteredRelevantDetailsUrls(movie.speciesUrls).map((url) => _apiConnector.getSpecies(url: url))),
      Future.wait(
        _getFilteredRelevantDetailsUrls(movie.locationUrls).map((url) => _apiConnector.getLocation(url: url)),
      ),
      Future.wait(_getFilteredRelevantDetailsUrls(movie.vehicleUrls).map((url) => _apiConnector.getVehicle(url: url))),
    ).wait;

    yield* _userDataRepository.watchUserMovies().map((userData) {
      final movieUserData = userData[movieId];

      return MovieDetails(
        movie: movie,
        people: people,
        species: species,
        locations: locations,
        vehicles: vehicles,
        isFavorite: movieUserData?.isFavorite ?? false,
        userRating: movieUserData?.userRating,
      );
    });
  }

  Future<void> setFavorite({required String movieId, required bool isFavorite}) {
    return _userDataRepository.setFavorite(movieId: movieId, isFavorite: isFavorite);
  }

  Future<void> setUserRating({required String movieId, required int? userRating}) {
    return _userDataRepository.setUserRating(movieId: movieId, userRating: userRating);
  }

  MovieListItem _buildMovieListItem(MovieDto movie, UserMovieData? userMovieData) {
    return MovieListItem(
      id: movie.id,
      title: movie.title,
      image: movie.image,
      description: movie.description,
      releaseDate: movie.releaseDate,
      runningTime: movie.runningTime,
      rottenTomatoesRating: movie.rottenTomatoesRating,
      isFavorite: userMovieData?.isFavorite ?? false,
      userRating: userMovieData?.userRating,
    );
  }

  Iterable<String> _getFilteredRelevantDetailsUrls(List<String> urls) {
    return urls.where((url) => Uri.parse(url).pathSegments.where((segment) => segment.isNotEmpty).length > 1);
  }
}
