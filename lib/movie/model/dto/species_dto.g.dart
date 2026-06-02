// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeciesDto _$SpeciesDtoFromJson(Map<String, dynamic> json) => SpeciesDto(
  id: json['id'] as String,
  name: json['name'] as String,
  classification: json['classification'] as String,
  eyeColors: json['eye_colors'] as String,
  hairColorDescription: json['hair_colors'] as String,
  peopleUrls: (json['people'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  filmUrls: (json['films'] as List<dynamic>).map((e) => e as String).toList(),
  url: json['url'] as String,
);
