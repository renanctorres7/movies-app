import 'package:json_annotation/json_annotation.dart';
import 'package:movies/app/features/search/domain/entities/entities.dart';

part 'search_results_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SearchResultsModel extends SearchResultsEntity {
  const SearchResultsModel({
    super.overview,
    super.releaseDate,
    super.genreIds,
    super.originalTitle,
    super.title,
    super.backdropPath,
    super.voteAverage,
  });

  factory SearchResultsModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultsModelToJson(this);

  factory SearchResultsModel.fromEntity(SearchResultsEntity entity) =>
      SearchResultsModel(
        overview: entity.overview,
        releaseDate: entity.releaseDate,
        genreIds: entity.genreIds,
        originalTitle: entity.originalTitle,
        title: entity.title,
        backdropPath: entity.backdropPath,
        voteAverage: entity.voteAverage,
      );
}
