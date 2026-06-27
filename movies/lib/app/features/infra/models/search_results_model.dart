import 'package:json_annotation/json_annotation.dart';
import 'package:movies/app/features/domain/entities/search_results.dart';

part 'search_results_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SearchResultsModel {
  final String? overview;
  final String? releaseDate;
  final List<int>? genreIds;
  final String? originalTitle;
  final String? title;
  final String? backdropPath;
  final num? voteAverage;

  const SearchResultsModel({
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.originalTitle,
    this.title,
    this.backdropPath,
    this.voteAverage,
  });

  factory SearchResultsModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultsModelToJson(this);

  SearchResults toEntity() {
    return SearchResults(
      overview: overview,
      releaseDate: releaseDate,
      genreIds: genreIds,
      originalTitle: originalTitle,
      title: title,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
    );
  }
}
