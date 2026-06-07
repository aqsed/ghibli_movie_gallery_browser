import 'package:ghibli_movie_gallery_browser/movie/model/dto/location_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/movie_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/person_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/species_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/vehicle_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/movie_list_item.dart';

class MovieDetails {
  final MovieDto movie;

  final List<PersonDto> people;

  final List<SpeciesDto> species;

  final List<LocationDto> locations;

  final List<VehicleDto> vehicles;

  final bool isFavorite;

  final int? userRating;

  const MovieDetails({
    required this.movie,
    required this.people,
    required this.species,
    required this.locations,
    required this.vehicles,
    required this.isFavorite,
    required this.userRating,
  });

  // TODO(jirka): check whether this is good placement
  factory MovieDetails.preview(MovieListItem item) => MovieDetails(
    movie: MovieDto(
      id: item.id,
      title: item.title,
      originalTitle: '',
      originalTitleRomanised: item.originalTitleRomanised,
      image: item.image,
      movieBanner: item.movieBanner,
      description: item.description,
      director: item.director,
      producer: item.producer,
      releaseDate: item.releaseDate,
      runningTime: item.runningTime,
      rottenTomatoesRating: item.rottenTomatoesRating,
      peopleUrls: const [],
      speciesUrls: const [],
      locationUrls: const [],
      vehicleUrls: const [],
      url: '',
    ),
    people: const [],
    species: const [],
    locations: const [],
    vehicles: const [],
    isFavorite: item.isFavorite,
    userRating: item.userRating,
  );

  MovieDetails copyWith({
    MovieDto? movie,
    List<PersonDto>? people,
    List<SpeciesDto>? species,
    List<LocationDto>? locations,
    List<VehicleDto>? vehicles,
    bool? isFavorite,
    int? userRating,
    bool useUserRatingNullable = false,
  }) {
    return MovieDetails(
      movie: movie ?? this.movie,
      people: people ?? this.people,
      species: species ?? this.species,
      locations: locations ?? this.locations,
      vehicles: vehicles ?? this.vehicles,
      isFavorite: isFavorite ?? this.isFavorite,
      userRating: useUserRatingNullable ? userRating : (userRating ?? this.userRating),
    );
  }
}
