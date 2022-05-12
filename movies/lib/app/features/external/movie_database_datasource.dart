import 'package:http/http.dart';
import 'package:movies/app/features/infra/datasources/search_results_datasource.dart';
import 'package:movies/app/features/infra/models/search_results_model.dart';

class MovieDatabaseDatasource implements SearchResultsDatasource {
  final Client client;

  MovieDatabaseDatasource(this.client);
  @override
  Future<List<SearchResultsModel>?> searchText(String text) {
    throw UnimplementedError();
  }
}
