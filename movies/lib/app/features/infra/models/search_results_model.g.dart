// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_results_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultsModel _$SearchResultsModelFromJson(Map<String, dynamic> json) =>
    SearchResultsModel(
      overview: json['overview'] as String?,
      releaseDate: json['release_date'] as String?,
      genreIds: json['genre_ids'] as List<dynamic>?,
      originalTitle: json['original_title'] as String?,
      title: json['title'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: json['vote_average'] as num?,
    );

Map<String, dynamic> _$SearchResultsModelToJson(SearchResultsModel instance) =>
    <String, dynamic>{
      'overview': instance.overview,
      'release_date': instance.releaseDate,
      'genre_ids': instance.genreIds,
      'original_title': instance.originalTitle,
      'title': instance.title,
      'backdrop_path': instance.backdropPath,
      'vote_average': instance.voteAverage,
    };
