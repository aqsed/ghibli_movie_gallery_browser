// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDto _$PersonDtoFromJson(Map<String, dynamic> json) => PersonDto(
  id: json['id'] as String,
  name: json['name'] as String,
  gender: json['gender'] as String,
  age: json['age'] as String,
  eyeColor: json['eye_color'] as String,
  hairColor: json['hair_color'] as String,
  filmUrls: (json['films'] as List<dynamic>).map((e) => e as String).toList(),
  speciesUrl: json['species'] as String,
  url: json['url'] as String,
);
