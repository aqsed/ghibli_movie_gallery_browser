import 'package:json_annotation/json_annotation.dart';

part 'user_movie_data.g.dart';

@JsonSerializable()
class UserMovieData {
  final bool isFavorite;

  final int? userRating;

  const UserMovieData({required this.isFavorite, required this.userRating});

  UserMovieData copyWith({bool? isFavorite, int? userRating}) {
    return UserMovieData(
      isFavorite: isFavorite ?? this.isFavorite,
      userRating: userRating ?? this.userRating,
    );
  }

  factory UserMovieData.fromJson(Map<String, dynamic> json) =>
      _$UserMovieDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserMovieDataToJson(this);
}
