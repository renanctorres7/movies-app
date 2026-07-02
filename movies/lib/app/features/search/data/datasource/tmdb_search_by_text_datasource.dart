import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies/app/core/core.dart';
import 'package:movies/app/features/search/data/datasource/tmdb_response_parser.dart';
import 'package:movies/app/features/search/infra/datasources/datasources.dart';
import 'package:movies/app/features/search/infra/models/models.dart';

class TmdbSearchByTextDatasource implements SearchByTextDatasource {
  final Client client;
  final String apiKey;

  TmdbSearchByTextDatasource(
    this.client, {
    String? apiKey,
  }) : apiKey = apiKey ?? TmdbConfig.apiKey;

  @override
  Future<List<SearchResultsModel>?> searchByText(String text) async {
    final result = await client.get(
      Uri.parse(TmdbEndpoints.getUrlMovieSearch(apiKey, text)),
    );

    if (result.statusCode == 200) {
      final json = jsonDecode(result.body) as Map<String, dynamic>;
      return parseTmdbSearchResults(json);
    }

    throw Exception('Failed to search movies');
  }
}
