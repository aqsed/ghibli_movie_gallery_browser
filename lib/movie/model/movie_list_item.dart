class MovieListItem {
  final String id;

  final String title;

  final String image;

  final String description;

  final String releaseDate;

  final String runningTime;

  final String rottenTomatoesRating;

  final bool isFavorite;

  final int? userRating;

  const MovieListItem({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.releaseDate,
    required this.runningTime,
    required this.rottenTomatoesRating,
    required this.isFavorite,
    required this.userRating,
  });
}
