import 'package:get_it/get_it.dart';
import 'package:movies/app/features/domain/repositories/search_genres_repository.dart';
import 'package:movies/app/features/domain/repositories/search_results_repository.dart';
import 'package:movies/app/features/domain/usecases/search_genres_usecase.dart';
import 'package:movies/app/features/external/movie_database/genres/movie_database_genres_datasource.dart';
import 'package:movies/app/features/external/movie_database/search/movie_database_search_datasource.dart';
import 'package:movies/app/features/infra/datasources/search_genres_datasource.dart';
import 'package:movies/app/features/infra/datasources/search_results_datasource.dart';
import 'package:movies/app/features/infra/repositories/search_genres_repository_impl.dart';
import 'package:movies/app/features/infra/repositories/search_results_repository_impl.dart';
import 'package:http/http.dart' as http;

import '../../features/domain/usecases/search_by_text.dart';

final s1 = GetIt.instance;

class DependencyCreator {
  static init() {
    s1.registerSingleton<http.Client>(http.Client());
    s1.registerSingleton<SearchResultsDatasource>(
        MovieDatabaseSearchDatasource(s1()));
    s1.registerSingleton<SearchGenresDatasource>(
        MovieDatabaseGenresDatasource(s1()));
    s1.registerSingleton<SearchResultsRepository>(
        SearchResultsRepositoryImpl(s1()));
    s1.registerSingleton<SearchGenresRepository>(
        SearchGenresRepositoryImpl(s1()));
    s1.registerSingleton<SearchGenresUsecase>(SearchGenresUsecaseImpl(s1()));
    s1.registerSingleton<SearchByText>(SearchByTextImpl(s1()));
  }
}
