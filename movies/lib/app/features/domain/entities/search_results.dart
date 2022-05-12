class SearchResults {
  final String posterPath;
  final bool adult;
  final String overview;

  final String releaseDate;

  final List genreIds;
  final int id;

  final String originalTitle;

  final String originalLanguage;

  final String title;

  final String backdropPath;
  final double popularity;

  final int voteCount;

  final bool video;

  final double voteAverage;

  SearchResults(
      {required this.posterPath,
      required this.adult,
      required this.overview,
      required this.releaseDate,
      required this.genreIds,
      required this.id,
      required this.originalTitle,
      required this.originalLanguage,
      required this.title,
      required this.backdropPath,
      required this.popularity,
      required this.voteCount,
      required this.video,
      required this.voteAverage});
}
