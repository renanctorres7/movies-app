class SearchResults {
  final String? posterPath;
  final bool? adult;
  final String? overview;

  final String? releaseDate;

  final List? genreIds;
  final int? id;

  final String? originalTitle;

  final String? originalLanguage;

  final String? title;

  final String? backdropPath;
  final num? popularity;

  final int? voteCount;

  final bool? video;

  final num? voteAverage;

  SearchResults(
      {this.posterPath,
      this.adult,
      this.overview,
      this.releaseDate,
      this.genreIds,
      this.id,
      this.originalTitle,
      this.originalLanguage,
      this.title,
      this.backdropPath,
      this.popularity,
      this.voteCount,
      this.video,
      this.voteAverage});
}
