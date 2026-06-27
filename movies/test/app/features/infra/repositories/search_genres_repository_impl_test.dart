import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/infra/datasources/search_genres_datasource.dart';
import 'package:movies/app/features/infra/models/search_genres_model.dart';
import 'package:movies/app/features/infra/repositories/search_genres_repository_impl.dart';

class SearchGenresDatasourceMock extends Mock
    implements SearchGenresDatasource {}

void main() {
  final datasource = SearchGenresDatasourceMock();
  final repository = SearchGenresRepositoryImpl(datasource);

  final testList = [
    const SearchGenresModel(id: 28, name: 'Ação'),
  ];

  test('Should return mapped genre entities', () async {
    when(() => datasource.searchGenres()).thenAnswer((_) async => testList);

    final result = await repository.getGenresList();

    result.fold(
      (_) => fail('Expected Right'),
      (entities) {
        expect(entities.length, 1);
        expect(entities.first.id, 28);
        expect(entities.first.name, 'Ação');
      },
    );
  });

  test('Should return UnexpectedFailure if datasource throws', () async {
    when(() => datasource.searchGenres()).thenThrow(Exception());

    final result = await repository.getGenresList();
    expect(result, Left(UnexpectedFailure()));
  });
}
