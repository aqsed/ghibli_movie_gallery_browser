// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleDto _$VehicleDtoFromJson(Map<String, dynamic> json) => VehicleDto(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  vehicleClass: json['vehicle_class'] as String,
  length: json['length'] as String,
  pilotUrl: json['pilot'] as String,
  filmUrls: (json['films'] as List<dynamic>).map((e) => e as String).toList(),
  url: json['url'] as String,
);
