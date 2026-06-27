import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies/app/features/external/movie_database/config/tmdb_config.dart';
import 'package:movies/app/features/external/movie_database/endpoints/movie_database_endpoints.dart';
import 'package:movies/app/features/infra/datasources/search_results_datasource.dart';
import 'package:movies/app/features/infra/models/search_results_model.dart';

class MovieDatabaseSearchDatasource implements SearchResultsDatasource {
  final Client client;
  final String apiKey;

  MovieDatabaseSearchDatasource(
    this.client, {
    String? apiKey,
  }) : apiKey = apiKey ?? TmdbConfig.apiKey;

  @override
  Future<List<SearchResultsModel>?> searchText(String text) async {
    final result = await client.get(Uri.parse(
        MovieDatabaseEndpoints.getUrlMovieSearch(apiKey, text)));

    if (result.statusCode == 200) {
      final json = jsonDecode(result.body) as Map<String, dynamic>;
      final jsonList = json['results'] as List;

      return jsonList
          .map((item) =>
              SearchResultsModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Failed to search movies');
  }
}
