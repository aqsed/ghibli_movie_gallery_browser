// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => LocationDto(
  id: json['id'] as String,
  name: json['name'] as String,
  climate: json['climate'] as String,
  terrain: json['terrain'] as String,
  surfaceWater: json['surface_water'] as String,
  peopleUrls: (json['residents'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  filmUrls: (json['films'] as List<dynamic>).map((e) => e as String).toList(),
  url: json['url'] as String,
);
