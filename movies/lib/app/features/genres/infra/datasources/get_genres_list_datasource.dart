import 'package:movies/app/features/genres/infra/models/genres_model.dart';

abstract class GetGenresListDatasource {
  Future<List<GenresModel>> getGenresList();
}
