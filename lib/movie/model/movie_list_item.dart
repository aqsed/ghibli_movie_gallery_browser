class MovieListItem {
  final String id;

  final String title;

  final String image;

  final String releaseDate;

  final String rottenTomatoesRating;

  final bool isFavorite;

  final int? userRating;

  const MovieListItem({
    required this.id,
    required this.title,
    required this.image,
    required this.releaseDate,
    required this.rottenTomatoesRating,
    required this.isFavorite,
    required this.userRating,
  });
}
