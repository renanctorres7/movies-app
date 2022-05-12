import 'package:movies/app/features/infra/models/search_results_model.dart';

abstract class SearchResultsDatasource {
  Future<List<SearchResultsModel>> searchText(String text);
}
