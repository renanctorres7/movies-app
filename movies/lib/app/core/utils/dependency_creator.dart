import 'package:get_it/get_it.dart';
import 'package:movies/app/features/domain/repositories/search_genres_repository.dart';
import 'package:movies/app/features/domain/repositories/search_results_repository.dart';
import 'package:movies/app/features/domain/usecases/genre_usecases.dart';
import 'package:movies/app/features/domain/usecases/search_by_text.dart';
import 'package:movies/app/features/domain/usecases/search_genres_usecase.dart';
import 'package:movies/app/features/external/movie_database/config/tmdb_config.dart';
import 'package:movies/app/features/external/movie_database/genres/movie_database_genres_datasource.dart';
import 'package:movies/app/features/external/movie_database/image/tmdb_image_url_builder.dart';
import 'package:movies/app/features/external/movie_database/search/movie_database_search_datasource.dart';
import 'package:movies/app/features/infra/contracts/image_url_builder.dart';
import 'package:movies/app/features/infra/datasources/search_genres_datasource.dart';
import 'package:movies/app/features/infra/datasources/search_results_datasource.dart';
import 'package:movies/app/features/infra/repositories/search_genres_repository_impl.dart';
import 'package:movies/app/features/infra/repositories/search_results_repository_impl.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

class DependencyCreator {
  static void init() {
    getIt.registerSingleton<http.Client>(http.Client());
    getIt.registerSingleton<ImageUrlBuilder>(TmdbImageUrlBuilder());
    getIt.registerSingleton<SearchResultsDatasource>(
      MovieDatabaseSearchDatasource(getIt(), apiKey: TmdbConfig.apiKey),
    );
    getIt.registerSingleton<SearchGenresDatasource>(
      MovieDatabaseGenresDatasource(getIt(), apiKey: TmdbConfig.apiKey),
    );
    getIt.registerSingleton<SearchResultsRepository>(
      SearchResultsRepositoryImpl(getIt()),
    );
    getIt.registerSingleton<SearchGenresRepository>(
      SearchGenresRepositoryImpl(getIt()),
    );
    getIt.registerSingleton<SearchGenresUsecase>(SearchGenresUsecaseImpl(getIt()));
    getIt.registerSingleton<SearchByText>(SearchByTextImpl(getIt()));
    getIt.registerSingleton(ResolveGenreNamesUsecase());
    getIt.registerSingleton(
      FilterSearchResultsByGenreUsecase(getIt<ResolveGenreNamesUsecase>()),
    );
    getIt.registerSingleton(
      CollectUniqueGenreNamesUsecase(getIt<ResolveGenreNamesUsecase>()),
    );
  }
}
