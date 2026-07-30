import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/core/utils/loading_status.dart';
import 'package:movies/app/features/genres/domain/usecases/usecases.dart';
import 'package:movies/app/features/search/data/datasource/tmdb_image_url_builder.dart';
import 'package:movies/app/features/search/domain/usecases/usecases.dart';
import 'package:movies/app/features/search/infra/models/models.dart';
import 'package:movies/app/features/search/presenter/stores/search_bloc.dart';
import 'package:movies/app/features/search/presenter/stores/search_event.dart';
import 'package:movies/app/features/search/presenter/stores/search_state.dart';

class SearchByTextUsecaseMock extends Mock implements SearchByTextUsecase {}

class GetPopularMoviesUsecaseMock extends Mock
    implements GetPopularMoviesUsecase {}

class GetGenresListUsecaseMock extends Mock implements GetGenresListUsecase {}

void main() {
  late SearchByTextUsecase searchByTextUsecase;
  late GetPopularMoviesUsecase getPopularMoviesUsecase;
  late GetGenresListUsecase getGenresListUsecase;
  

  SearchBloc createBloc() {
    return SearchBloc(
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
  }

  setUp(() {
    searchByTextUsecase = SearchByTextUsecaseMock();
    getPopularMoviesUsecase = GetPopularMoviesUsecaseMock();
    getGenresListUsecase = GetGenresListUsecaseMock();
  });

  blocTest<SearchBloc, SearchState>(
    'emits complete when popular movies succeed',
    build: () {
      final results = [const SearchResultsModel(title: 'Popular Movie')];
      when(() => getPopularMoviesUsecase())
          .thenAnswer((_) async => Right(results));
      return createBloc();
    },
    act: (bloc) => bloc.add(SearchPopularMoviesRequested()),
    expect: () => [
      isA<SearchState>().having(
        (s) => s.loadingStatus,
        'status',
        LoadingStatus.loading,
      ),
      isA<SearchState>()
          .having((s) => s.loadingStatus, 'status', LoadingStatus.complete)
          .having((s) => s.results.length, 'results', 1),
    ],
  );

  blocTest<SearchBloc, SearchState>(
    'emits complete when search by text succeeds',
    build: () {
      const text = 'vingadores';
      final results = [const SearchResultsModel(title: 'Vingadores')];
      when(() => searchByTextUsecase(text))
          .thenAnswer((_) async => Right(results));
      return createBloc();
    },
    act: (bloc) => bloc.add(SearchByTextRequested('vingadores')),
    expect: () => [
      isA<SearchState>().having(
        (s) => s.loadingStatus,
        'status',
        LoadingStatus.loading,
      ),
      isA<SearchState>()
          .having((s) => s.loadingStatus, 'status', LoadingStatus.complete)
          .having((s) => s.results.length, 'results', 1),
    ],
  );

  blocTest<SearchBloc, SearchState>(
    'emits error when search by text fails',
    build: () {
      const text = 'vingadores';
      when(() => searchByTextUsecase(text))
          .thenAnswer((_) async => Left(DataSourceError()));
      return createBloc();
    },
    act: (bloc) => bloc.add(SearchByTextRequested('vingadores')),
    expect: () => [
      isA<SearchState>().having(
        (s) => s.loadingStatus,
        'status',
        LoadingStatus.loading,
      ),
      isA<SearchState>()
          .having((s) => s.loadingStatus, 'status', LoadingStatus.error)
          .having((s) => s.failureMessage, 'message', isNotEmpty),
    ],
  );
}
