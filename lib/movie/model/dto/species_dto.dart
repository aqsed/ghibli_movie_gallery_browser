import 'package:json_annotation/json_annotation.dart';

part 'species_dto.g.dart';

@JsonSerializable(createToJson: false)
class SpeciesDto {
  final String id;

  final String name;

  final String classification;

  @JsonKey(name: 'eye_colors')
  final String eyeColors;

  @JsonKey(name: 'hair_colors')
  final String hairColorDescription;

  @JsonKey(name: 'people')
  final List<String> peopleUrls;

  @JsonKey(name: 'films')
  final List<String> filmUrls;

  final String url;

  const SpeciesDto({
    required this.id,
    required this.name,
    required this.classification,
    required this.eyeColors,
    required this.hairColorDescription,
    required this.peopleUrls,
    required this.filmUrls,
    required this.url,
  });

  factory SpeciesDto.fromJson(Map<String, dynamic> json) =>
      _$SpeciesDtoFromJson(json);
}
