import 'package:get_it/get_it.dart';
import 'package:movies/app/features/genres/data/datasource/datasource.dart';
import 'package:movies/app/features/genres/domain/repository/repository.dart';
import 'package:movies/app/features/genres/domain/usecases/usecases.dart';
import 'package:movies/app/features/genres/infra/datasources/datasources.dart';
import 'package:movies/app/features/genres/infra/repository/repository.dart';
import 'package:movies/app/features/search/data/datasource/datasource.dart';
import 'package:movies/app/features/search/domain/repository/repository.dart';
import 'package:movies/app/features/search/domain/usecases/usecases.dart';
import 'package:movies/app/features/search/infra/contracts/image_url_builder.dart';
import 'package:movies/app/features/search/infra/datasources/datasources.dart';
import 'package:movies/app/features/search/infra/repository/repository.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

class DependencyCreator {
  static void init() {
    getIt.registerSingleton<http.Client>(http.Client());
    getIt.registerSingleton<ImageUrlBuilder>(TmdbImageUrlBuilder());

    getIt.registerSingleton<SearchByTextDatasource>(
      TmdbSearchByTextDatasource(getIt()),
    );
    getIt.registerSingleton<GetPopularMoviesDatasource>(
      TmdbGetPopularMoviesDatasource(getIt()),
    );
    getIt.registerSingleton<GetGenresListDatasource>(
      TmdbGetGenresDatasource(getIt()),
    );

    getIt.registerSingleton<SearchByTextRepository>(
      SearchByTextRepositoryImpl(getIt()),
    );
    getIt.registerSingleton<GetPopularMoviesRepository>(
      GetPopularMoviesRepositoryImpl(getIt()),
    );
    getIt.registerSingleton<GetGenresListRepository>(
      GetGenresListRepositoryImpl(getIt()),
    );

    getIt.registerSingleton<GetGenresListUsecase>(
      GetGenresListUsecaseImpl(getIt()),
    );
    getIt.registerSingleton<SearchByTextUsecase>(
      SearchByTextUsecaseImpl(getIt()),
    );
    getIt.registerSingleton<GetPopularMoviesUsecase>(
      GetPopularMoviesUsecaseImpl(getIt()),
    );
    getIt.registerSingleton(ResolveGenreNamesUsecase());
    getIt.registerSingleton(
      FilterSearchResultsByGenreUsecase(getIt<ResolveGenreNamesUsecase>()),
    );
    getIt.registerSingleton(
      CollectUniqueGenreNamesUsecase(getIt<ResolveGenreNamesUsecase>()),
    );
  }
}
