import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies/app/features/infra/datasources/search_results_datasource.dart';
import 'package:movies/app/features/infra/models/search_results_model.dart';

import '../../../../core/keys/movie_database/movie_database_environment.dart';
import '../endpoints/movie_database_endpoints.dart';

class MovieDatabaseSearchDatasource implements SearchResultsDatasource {
  final Client client;

  MovieDatabaseSearchDatasource(this.client);
  @override
  Future<List<SearchResultsModel>?> searchText(String text) async {
    final result = await client.get(Uri.parse(
        MovieDatabaseEndpoints.getUrlMovieSearch(Environment.apiKey, text)));
    List<SearchResultsModel> list = [];
    if (result.statusCode == 200) {
      final json = jsonDecode(result.body);
      final jsonList = json['results'] as List;

      jsonList.asMap().forEach((key, value) async {
        var map = jsonDecode(jsonEncode(value));
        list.add(SearchResultsModel.fromJson(map));
      });

      return list;
    } else {
      throw Exception();
    }
  }
}
