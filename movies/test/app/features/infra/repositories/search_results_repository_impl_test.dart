import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/infra/datasources/search_results_datasource.dart';
import 'package:movies/app/features/infra/models/search_results_model.dart';
import 'package:movies/app/features/infra/repositories/search_results_repository_impl.dart';

class SearchResultsDatasourceMock extends Mock
    implements SearchResultsDatasource {}

void main() {
  final datasource = SearchResultsDatasourceMock();
  final repository = SearchResultsRepositoryImpl(datasource);
  const text = 'teste';

  final testList = [
    SearchResultsModel(
      overview: 'Overview',
      releaseDate: '2012-09-25',
      genreIds: [99],
      originalTitle: 'Original',
      title: 'Title',
      backdropPath: '/path.jpg',
      voteAverage: 3.88,
    ),
  ];

  test('Should return mapped search result entities', () async {
    when(() => datasource.searchText(text)).thenAnswer((_) async => testList);

    final result = await repository.getListResults(text);

    result.fold(
      (_) => fail('Expected Right'),
      (entities) {
        expect(entities.length, 1);
        expect(entities.first.title, 'Title');
        expect(entities.first.genreIds, [99]);
      },
    );
  });

  test('Should return EmptyResultFailure if datasource returns null', () async {
    when(() => datasource.searchText(text)).thenAnswer((_) async => null);

    final result = await repository.getListResults(text);
    expect(result, Left(EmptyResultFailure()));
  });

  test('Should return UnexpectedFailure if datasource throws', () async {
    when(() => datasource.searchText(text)).thenThrow(Exception());

    final result = await repository.getListResults(text);
    expect(result, Left(UnexpectedFailure()));
  });
}
