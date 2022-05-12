import 'package:movies/app/features/infra/models/search_genres_model.dart';

abstract class SearchGenresDatasource {
  Future<List<SearchGenresModel>?> searchGenres();
}
