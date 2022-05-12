import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies/app/features/infra/datasources/search_genres_datasource.dart';
import 'package:movies/app/features/infra/models/search_genres_model.dart';

class MovieDatabaseGenresDatasource implements SearchGenresDatasource {
  final Client client;

  MovieDatabaseGenresDatasource(this.client);

  @override
  Future<List<SearchGenresModel>> searchGenres() {
    throw UnimplementedError();
  }
}
