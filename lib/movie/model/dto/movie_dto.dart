import 'package:json_annotation/json_annotation.dart';

part 'movie_dto.g.dart';

@JsonSerializable(createToJson: false)
class MovieDto {
  final String id;

  final String title;

  @JsonKey(name: 'original_title')
  final String originalTitle;

  @JsonKey(name: 'original_title_romanised')
  final String originalTitleRomanised;

  final String image;

  @JsonKey(name: 'movie_banner')
  final String movieBanner;

  final String description;

  final String director;

  final String producer;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  @JsonKey(name: 'running_time')
  final String runningTime;

  @JsonKey(name: 'rt_score')
  final String rottenTomatoesRating;

  @JsonKey(name: 'people')
  final List<String> peopleUrls;

  @JsonKey(name: 'species')
  final List<String> speciesUrls;

  @JsonKey(name: 'locations')
  final List<String> locationUrls;

  @JsonKey(name: 'vehicles')
  final List<String> vehicleUrls;

  final String url;

  const MovieDto({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.originalTitleRomanised,
    required this.image,
    required this.movieBanner,
    required this.description,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.runningTime,
    required this.rottenTomatoesRating,
    required this.peopleUrls,
    required this.speciesUrls,
    required this.locationUrls,
    required this.vehicleUrls,
    required this.url,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) => _$MovieDtoFromJson(json);
}
