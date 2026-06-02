// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDto _$MovieDtoFromJson(Map<String, dynamic> json) => MovieDto(
  id: json['id'] as String,
  title: json['title'] as String,
  originalTitle: json['original_title'] as String,
  originalTitleRomanised: json['original_title_romanised'] as String,
  image: json['image'] as String,
  movieBanner: json['movie_banner'] as String,
  description: json['description'] as String,
  director: json['director'] as String,
  producer: json['producer'] as String,
  releaseDate: json['release_date'] as String,
  runningTime: json['running_time'] as String,
  rottenTomatoesRating: json['rt_score'] as String,
  peopleUrls: (json['people'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  speciesUrls: (json['species'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  locationUrls: (json['locations'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  vehicleUrls: (json['vehicles'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  url: json['url'] as String,
);
