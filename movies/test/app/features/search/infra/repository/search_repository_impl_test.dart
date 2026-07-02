import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/search/infra/datasources/datasources.dart';
import 'package:movies/app/features/search/infra/models/models.dart';
import 'package:movies/app/features/search/infra/repository/repository.dart';

class SearchByTextDatasourceMock extends Mock
    implements SearchByTextDatasource {}

class GetPopularMoviesDatasourceMock extends Mock
    implements GetPopularMoviesDatasource {}

void main() {
  group('SearchByTextRepositoryImpl', () {
    final datasource = SearchByTextDatasourceMock();
    final repository = SearchByTextRepositoryImpl(datasource);
    const text = 'teste';

    final testList = [
      const SearchResultsModel(
        overview: 'Overview',
        releaseDate: '2012-09-25',
        genreIds: [99],
        originalTitle: 'Original',
        title: 'Title',
        backdropPath: '/path.jpg',
        voteAverage: 3.88,
      ),
    ];

    test('Should return search result entities', () async {
      when(() => datasource.searchByText(text)).thenAnswer((_) async => testList);

      final result = await repository.searchByText(text);

      result.fold(
        (_) => fail('Expected Right'),
        (entities) {
          expect(entities.length, 1);
          expect(entities.first.title, 'Title');
          expect(entities.first.genreIds, [99]);
        },
      );
    });

    test('Should return NullError if datasource returns null', () async {
      when(() => datasource.searchByText(text)).thenAnswer((_) async => null);

      final result = await repository.searchByText(text);
      expect(result, Left(NullError()));
    });

    test('Should return DataSourceError if datasource throws', () async {
      when(() => datasource.searchByText(text)).thenThrow(Exception());

      final result = await repository.searchByText(text);
      expect(result, Left(DataSourceError()));
    });
  });

  group('GetPopularMoviesRepositoryImpl', () {
    final datasource = GetPopularMoviesDatasourceMock();
    final repository = GetPopularMoviesRepositoryImpl(datasource);

    final testList = [
      const SearchResultsModel(
        title: 'Title',
      ),
    ];

    test('Should return popular movie entities', () async {
      when(() => datasource.getPopularMovies())
          .thenAnswer((_) async => testList);

      final result = await repository.getPopularMovies();

      result.fold(
        (_) => fail('Expected Right'),
        (entities) {
          expect(entities.length, 1);
          expect(entities.first.title, 'Title');
        },
      );
    });

    test('Should return DataSourceError if popular movies throws', () async {
      when(() => datasource.getPopularMovies()).thenThrow(Exception());

      final result = await repository.getPopularMovies();
      expect(result, Left(DataSourceError()));
    });
  });
}
