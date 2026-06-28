import 'package:movies/app/features/search/infra/models/search_results_model.dart';

abstract class SearchByTextDatasource {
  Future<List<SearchResultsModel>?> searchByText(String text);
}
