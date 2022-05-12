import 'dart:convert';

import 'package:movies/app/features/domain/entities/search_results.dart';

class SearchResultsModel extends SearchResults {
  SearchResultsModel(
      {required String posterPath,
      required bool adult,
      required String overview,
      required String releaseDate,
      required List genreIds,
      required int id,
      required String originalTitle,
      required String originalLanguage,
      required String title,
      required String backdropPath,
      required double popularity,
      required int voteCount,
      required bool video,
      required double voteAverage})
      : super(
            posterPath: posterPath,
            adult: adult,
            overview: overview,
            releaseDate: releaseDate,
            genreIds: genreIds,
            id: id,
            originalTitle: originalTitle,
            originalLanguage: originalLanguage,
            title: title,
            backdropPath: backdropPath,
            popularity: popularity,
            voteCount: voteCount,
            video: video,
            voteAverage: voteAverage);

  Map<String, dynamic> toMap() {
    return {
      'posterPath': posterPath,
      'adult': adult,
      'overview': overview,
      'releaseDate': releaseDate,
      'genreIds': genreIds,
      'id': id,
      'originalTitle': originalTitle,
      'originalLanguage': originalLanguage,
      'title': title,
      'backdropPath': backdropPath,
      'popularity': popularity,
      'voteCount': voteCount,
      'video': video,
      'voteAverage': voteAverage
    };
  }

  static SearchResultsModel fromMap(Map<String, dynamic> map) {
    return SearchResultsModel(
        posterPath: map['poster_path'],
        adult: map['adult'],
        overview: map['overview'],
        releaseDate: map['release_date'],
        genreIds: map['genre_ids'],
        id: map['id'],
        originalTitle: map['original_title'],
        originalLanguage: map['original_language'],
        title: map['title'],
        backdropPath: map['backdrop_path'],
        popularity: map['popularity'],
        voteCount: map['vote_count'],
        video: map['video'],
        voteAverage: map['vote_average']);
  }

  String toJson() => jsonEncode(toMap());

  static SearchResultsModel fromJson(String source) =>
      fromMap(jsonDecode(source));
}
