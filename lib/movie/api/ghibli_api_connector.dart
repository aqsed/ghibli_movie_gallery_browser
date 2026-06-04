import 'package:dio/dio.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/location_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/movie_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/person_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/species_dto.dart';
import 'package:ghibli_movie_gallery_browser/movie/model/dto/vehicle_dto.dart';

const _FILMS_API_ENDPOINT = '/films';

class GhibliApiConnector {
  final Dio _dio;

  const GhibliApiConnector(this._dio);

  Future<List<MovieDto>> getMovies() async {
    final response = await _dio.get(_FILMS_API_ENDPOINT);

    return (response.data as List<dynamic>)
        .map((movieJson) => MovieDto.fromJson(movieJson as Map<String, dynamic>))
        .toList();
  }

  Future<MovieDto> getMovie({required String movieId}) async {
    final response = await _dio.get('$_FILMS_API_ENDPOINT/$movieId');

    return MovieDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<PersonDto> getPerson({required String url}) => _getObject(url, PersonDto.fromJson);

  Future<SpeciesDto> getSpecies({required String url}) => _getObject(url, SpeciesDto.fromJson);

  Future<LocationDto> getLocation({required String url}) => _getObject(url, LocationDto.fromJson);

  Future<VehicleDto> getVehicle({required String url}) => _getObject(url, VehicleDto.fromJson);

  Future<T> _getObject<T>(String url, T Function(Map<String, dynamic>) fromJson) async {
    final response = await _dio.get(url);

    return fromJson(response.data as Map<String, dynamic>);
  }
}
