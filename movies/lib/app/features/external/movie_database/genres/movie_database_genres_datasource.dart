import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies/app/features/external/movie_database/config/tmdb_config.dart';
import 'package:movies/app/features/external/movie_database/endpoints/movie_database_endpoints.dart';
import 'package:movies/app/features/infra/datasources/search_genres_datasource.dart';
import 'package:movies/app/features/infra/models/search_genres_model.dart';

class MovieDatabaseGenresDatasource implements SearchGenresDatasource {
  final Client client;
  final String apiKey;

  MovieDatabaseGenresDatasource(
    this.client, {
    String? apiKey,
  }) : apiKey = apiKey ?? TmdbConfig.apiKey;

  @override
  Future<List<SearchGenresModel>> searchGenres() async {
    final result = await client.get(
        Uri.parse(MovieDatabaseEndpoints.getGenresSearch(apiKey)));

    if (result.statusCode == 200) {
      final json = jsonDecode(result.body) as Map<String, dynamic>;
      final jsonList = json['genres'] as List;

      return jsonList
          .map((item) => SearchGenresModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Failed to load genres');
  }
}
