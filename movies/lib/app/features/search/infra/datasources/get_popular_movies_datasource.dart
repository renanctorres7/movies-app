import 'package:movies/app/features/search/infra/models/search_results_model.dart';

abstract class GetPopularMoviesDatasource {
  Future<List<SearchResultsModel>?> getPopularMovies();
}
