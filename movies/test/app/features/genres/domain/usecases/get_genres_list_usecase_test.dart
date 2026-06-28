import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/genres/domain/entities/entities.dart';
import 'package:movies/app/features/genres/domain/repository/repository.dart';
import 'package:movies/app/features/genres/domain/usecases/usecases.dart';

class GetGenresListRepositoryMock extends Mock
    implements GetGenresListRepository {}

void main() {
  final repository = GetGenresListRepositoryMock();
  final usecase = GetGenresListUsecaseImpl(repository);

  final list = <GenresEntity>[];

  test('Should receive a genres list', () async {
    when(() => repository.getGenresList()).thenAnswer((_) async => Right(list));
    final result = await usecase.call();

    expect(result, Right(list));
  });

  test('Should return DataSourceError when repository fails', () async {
    when(() => repository.getGenresList())
        .thenAnswer((_) async => Left(DataSourceError()));
    final result = await usecase.call();

    expect(result, Left(DataSourceError()));
  });
}
