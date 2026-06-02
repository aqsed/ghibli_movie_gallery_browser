import 'package:json_annotation/json_annotation.dart';

part 'vehicle_dto.g.dart';

@JsonSerializable(createToJson: false)
class VehicleDto {
  final String id;

  final String name;

  final String description;

  @JsonKey(name: 'vehicle_class')
  final String vehicleClass;

  final String length;

  @JsonKey(name: 'pilot')
  final String pilotUrl;

  @JsonKey(name: 'films')
  final List<String> filmUrls;

  final String url;

  const VehicleDto({
    required this.id,
    required this.name,
    required this.description,
    required this.vehicleClass,
    required this.length,
    required this.pilotUrl,
    required this.filmUrls,
    required this.url,
  });

  factory VehicleDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleDtoFromJson(json);
}
