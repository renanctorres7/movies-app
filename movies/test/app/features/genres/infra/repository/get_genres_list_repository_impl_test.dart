import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/genres/infra/datasources/datasources.dart';
import 'package:movies/app/features/genres/infra/models/models.dart';
import 'package:movies/app/features/genres/infra/repository/repository.dart';

class GetGenresListDatasourceMock extends Mock
    implements GetGenresListDatasource {}

void main() {
  final datasource = GetGenresListDatasourceMock();
  final repository = GetGenresListRepositoryImpl(datasource);

  final testList = [
    const GenresModel(id: 28, name: 'Ação'),
  ];

  test('Should return genre entities', () async {
    when(() => datasource.getGenresList()).thenAnswer((_) async => testList);

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

  test('Should return DataSourceError if datasource throws', () async {
    when(() => datasource.getGenresList()).thenThrow(Exception());

    final result = await repository.getGenresList();
    expect(result, Left(DataSourceError()));
  });
}
