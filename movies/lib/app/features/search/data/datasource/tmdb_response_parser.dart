import 'package:movies/app/features/search/infra/models/search_results_model.dart';

List<SearchResultsModel> parseTmdbSearchResults(Map<String, dynamic> json) {
  final jsonList = json['results'] as List;

  return jsonList
      .map((item) => SearchResultsModel.fromJson(item as Map<String, dynamic>))
      .toList();
}
