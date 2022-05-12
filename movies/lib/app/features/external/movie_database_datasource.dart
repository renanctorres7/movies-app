import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies/app/core/keys/movie_database_api_key.dart';
import 'package:movies/app/features/external/endpoints/movie_database_endpoints.dart';
import 'package:movies/app/features/infra/datasources/search_results_datasource.dart';
import 'package:movies/app/features/infra/models/search_results_model.dart';

class MovieDatabaseDatasource implements SearchResultsDatasource {
  final Client client;

  MovieDatabaseDatasource(this.client);
  @override
  Future<List<SearchResultsModel>?> searchText(String text) async {
    final result = await client.get(Uri.parse(
        MovieDatabaseEndpoints.getUrlMovieSearch(
            MovieDatabaseApiKeys.apiKey, text)));

    if (result.statusCode == 200) {
      final json = jsonDecode(result.body);
      final jsonList = json['results'] as List;
      final list = jsonList
          .map((map) => SearchResultsModel(
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
              voteAverage: map['vote_average']))
          .toList();

      return list;
    } else {
      throw Exception();
    }
  }
}
