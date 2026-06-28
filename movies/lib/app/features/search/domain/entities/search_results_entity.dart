abstract class SearchResultsEntity {
  final String? overview;
  final String? releaseDate;
  final List<int>? genreIds;
  final String? originalTitle;
  final String? title;
  final String? backdropPath;
  final num? voteAverage;

  const SearchResultsEntity({
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.originalTitle,
    this.title,
    this.backdropPath,
    this.voteAverage,
  });
}
