import 'package:json_annotation/json_annotation.dart';
import 'package:movies/app/features/domain/entities/search_results.dart';

part 'search_results_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SearchResultsModel extends SearchResults {
  SearchResultsModel(
      {String? overview,
      String? releaseDate,
      List? genreIds,
      String? originalTitle,
      String? title,
      String? backdropPath,
      num? voteAverage})
      : super(
            overview: overview,
            releaseDate: releaseDate,
            genreIds: genreIds,
            originalTitle: originalTitle,
            title: title,
            backdropPath: backdropPath,
            voteAverage: voteAverage);

  factory SearchResultsModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultsModelToJson(this);
}
