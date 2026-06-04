// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_movie_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMovieData _$UserMovieDataFromJson(Map<String, dynamic> json) =>
    UserMovieData(
      isFavorite: json['isFavorite'] as bool,
      userRating: (json['userRating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserMovieDataToJson(UserMovieData instance) =>
    <String, dynamic>{
      'isFavorite': instance.isFavorite,
      'userRating': instance.userRating,
    };
