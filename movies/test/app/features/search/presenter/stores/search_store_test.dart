import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/utils/loading_status.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/genres/domain/usecases/usecases.dart';
import 'package:movies/app/features/search/data/datasource/tmdb_image_url_builder.dart';
import 'package:movies/app/features/search/domain/usecases/usecases.dart';
import 'package:movies/app/features/search/infra/models/models.dart';
import 'package:movies/app/features/search/presenter/stores/search_store.dart';

class SearchByTextUsecaseMock extends Mock implements SearchByTextUsecase {}

class GetPopularMoviesUsecaseMock extends Mock
    implements GetPopularMoviesUsecase {}

class GetGenresListUsecaseMock extends Mock implements GetGenresListUsecase {}

void main() {
  late SearchStore store;
  late SearchByTextUsecase searchByTextUsecase;
  late GetPopularMoviesUsecase getPopularMoviesUsecase;
  late GetGenresListUsecase getGenresListUsecase;

  setUp(() {
    Get.testMode = true;
    searchByTextUsecase = SearchByTextUsecaseMock();
    getPopularMoviesUsecase = GetPopularMoviesUsecaseMock();
    getGenresListUsecase = GetGenresListUsecaseMock();
    store = SearchStore(
      searchByTextUsecase: searchByTextUsecase,
      getPopularMoviesUsecase: getPopularMoviesUsecase,
      getGenresListUsecase: getGenresListUsecase,
      resolveGenreNamesUsecase: ResolveGenreNamesUsecase(),
      filterByGenreUsecase:
          FilterSearchResultsByGenreUsecase(ResolveGenreNamesUsecase()),
      collectUniqueGenreNamesUsecase:
          CollectUniqueGenreNamesUsecase(ResolveGenreNamesUsecase()),
      imageUrlBuilder: TmdbImageUrlBuilder(),
    );
  });

  tearDown(() {
    store.onClose();
    Get.reset();
  });

  test('loadPopularMovies sets complete status when use case succeeds', () async {
    final results = [const SearchResultsModel(title: 'Popular Movie')];

    when(() => getPopularMoviesUsecase()).thenAnswer((_) async => Right(results));
    when(() => getGenresListUsecase()).thenAnswer((_) async => const Right([]));

    await store.loadPopularMovies();

    expect(store.loadingStatus.value, LoadingStatus.complete);
    expect(store.listResults.length, 1);
  });

  test('searchMovies sets complete status when use case succeeds', () async {
    const text = 'vingadores';
    final results = [const SearchResultsModel(title: 'Vingadores')];

    when(() => searchByTextUsecase(text)).thenAnswer((_) async => Right(results));
    when(() => getGenresListUsecase()).thenAnswer((_) async => const Right([]));

    await store.searchMovies(text);

    expect(store.loadingStatus.value, LoadingStatus.complete);
    expect(store.listResults.length, 1);
  });

  test('searchMovies sets error status when use case fails', () async {
    const text = 'vingadores';

    when(() => searchByTextUsecase(text))
        .thenAnswer((_) async => Left(DataSourceError()));

    await store.searchMovies(text);

    expect(store.loadingStatus.value, LoadingStatus.error);
    expect(store.failureMessage.value, isNotEmpty);
  });
}
