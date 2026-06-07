import 'package:ghibli_movie_gallery_browser/movie/model/dto/location_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/movie_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/person_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/species_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/vehicle_dto.dart';

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
