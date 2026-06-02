import 'package:json_annotation/json_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable(createToJson: false)
class LocationDto {
  final String id;

  final String name;

  final String climate;

  final String terrain;

  @JsonKey(name: 'surface_water')
  final String surfaceWater;

  @JsonKey(name: 'residents')
  final List<String> peopleUrls;

  @JsonKey(name: 'films')
  final List<String> filmUrls;

  final String url;

  const LocationDto({
    required this.id,
    required this.name,
    required this.climate,
    required this.terrain,
    required this.surfaceWater,
    required this.peopleUrls,
    required this.filmUrls,
    required this.url,
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) => _$LocationDtoFromJson(json);
}
