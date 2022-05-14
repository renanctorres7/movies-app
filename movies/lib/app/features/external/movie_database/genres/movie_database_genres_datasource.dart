import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies/app/core/keys/movie_database_api_key.dart';
import 'package:movies/app/features/external/movie_database/endpoints/movie_database_endpoints.dart';
import 'package:movies/app/features/infra/datasources/search_genres_datasource.dart';
import 'package:movies/app/features/infra/models/search_genres_model.dart';

class MovieDatabaseGenresDatasource implements SearchGenresDatasource {
  final Client client;

  MovieDatabaseGenresDatasource(this.client);

  @override
  Future<List<SearchGenresModel>> searchGenres() async {
    final result = await client.get(Uri.parse(
        MovieDatabaseEndpoints.getGenresSearch(MovieDatabaseApiKeys.apiKey)));

    List<SearchGenresModel> list = [];
    if (result.statusCode == 200) {
      final json = jsonDecode(result.body);
      final jsonList = json['genres'] as List;

      jsonList.asMap().forEach((key, value) async {
        var map = jsonDecode(jsonEncode(value));
        list.add(SearchGenresModel(id: map['id'], name: map['name']));
      });

      return list;
    } else {
      throw Exception();
    }
  }
}
