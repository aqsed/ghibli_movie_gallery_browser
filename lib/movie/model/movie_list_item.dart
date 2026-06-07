class MovieListItem {
  final String id;

  final String title;

  final String originalTitleRomanised;

  final String image;

  final String movieBanner;

  final String description;

  final String director;

  final String producer;

  final String releaseDate;

  final String runningTime;

  final String rottenTomatoesRating;

  final bool isFavorite;

  final int? userRating;

  const MovieListItem({
    required this.id,
    required this.title,
    required this.originalTitleRomanised,
    required this.image,
    required this.movieBanner,
    required this.description,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.runningTime,
    required this.rottenTomatoesRating,
    required this.isFavorite,
    required this.userRating,
  });
}
