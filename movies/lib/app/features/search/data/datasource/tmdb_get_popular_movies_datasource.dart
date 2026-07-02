import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies/app/core/core.dart';
import 'package:movies/app/features/search/data/datasource/tmdb_response_parser.dart';
import 'package:movies/app/features/search/infra/datasources/datasources.dart';
import 'package:movies/app/features/search/infra/models/models.dart';

class TmdbGetPopularMoviesDatasource implements GetPopularMoviesDatasource {
  final Client client;
  final String apiKey;

  TmdbGetPopularMoviesDatasource(
    this.client, {
    String? apiKey,
  }) : apiKey = apiKey ?? TmdbConfig.apiKey;

  @override
  Future<List<SearchResultsModel>?> getPopularMovies() async {
    final result = await client.get(
      Uri.parse(TmdbEndpoints.getPopularMovies(apiKey)),
    );

    if (result.statusCode == 200) {
      final json = jsonDecode(result.body) as Map<String, dynamic>;
      return parseTmdbSearchResults(json);
    }

    throw Exception('Failed to load popular movies');
  }
}
