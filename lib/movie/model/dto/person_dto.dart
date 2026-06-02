import 'package:json_annotation/json_annotation.dart';

part 'person_dto.g.dart';

@JsonSerializable(createToJson: false)
class PersonDto {
  final String id;

  final String name;

  final String gender;

  final String age;

  @JsonKey(name: 'eye_color')
  final String eyeColor;

  @JsonKey(name: 'hair_color')
  final String hairColor;

  @JsonKey(name: 'films')
  final List<String> filmUrls;

  @JsonKey(name: 'species')
  final String speciesUrl;

  final String url;

  const PersonDto({
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.eyeColor,
    required this.hairColor,
    required this.filmUrls,
    required this.speciesUrl,
    required this.url,
  });

  factory PersonDto.fromJson(Map<String, dynamic> json) =>
      _$PersonDtoFromJson(json);
}
