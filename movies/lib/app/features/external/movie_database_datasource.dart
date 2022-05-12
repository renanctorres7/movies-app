import 'package:movies/app/features/infra/datasources/search_results_datasource.dart';
import 'package:movies/app/features/infra/models/search_results_model.dart';

class MovieDatabaseDatasource implements SearchResultsDatasource {
  @override
  Future<List<SearchResultsModel>?> searchText(String text) {
    throw UnimplementedError();
  }
}
