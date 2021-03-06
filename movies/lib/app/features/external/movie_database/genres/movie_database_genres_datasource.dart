import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies/app/core/keys/movie_database/movie_database_environment.dart';
import 'package:movies/app/features/external/movie_database/endpoints/movie_database_endpoints.dart';
import 'package:movies/app/features/infra/datasources/search_genres_datasource.dart';
import 'package:movies/app/features/infra/models/search_genres_model.dart';

class MovieDatabaseGenresDatasource implements SearchGenresDatasource {
  final Client client;

  MovieDatabaseGenresDatasource(this.client);

  @override
  Future<List<SearchGenresModel>> searchGenres() async {
    final result = await client.get(
        Uri.parse(MovieDatabaseEndpoints.getGenresSearch(Environment.apiKey)));

    List<SearchGenresModel> list = [];
    if (result.statusCode == 200) {
      final json = jsonDecode(result.body);
      final jsonList = json['genres'];

      jsonList.asMap().forEach((key, value) {
        var map = jsonDecode(jsonEncode(value));
        list.add(SearchGenresModel.fromJson(map));
      });

      return list;
    } else {
      throw Exception();
    }
  }
}
