import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/search/domain/repository/repository.dart';
import 'package:movies/app/features/search/domain/usecases/usecases.dart';
import 'package:movies/app/features/search/infra/models/models.dart';

class SearchByTextRepositoryMock extends Mock implements SearchByTextRepository {}

void main() {
  final repository = SearchByTextRepositoryMock();
  final usecase = SearchByTextUsecaseImpl(repository);
  const text = 'teste';
  final list = <SearchResultsModel>[];

  test('Should return a list with results', () async {
    when(() => repository.searchByText(any()))
        .thenAnswer((_) async => Right(list));

    final result = await usecase(text);
    expect(result, Right(list));
    verify(() => repository.searchByText(text)).called(1);
  });

  test('Should return InvalidSearchText when text is empty', () async {
    final result = await usecase('');
    expect(result, Left(InvalidSearchText()));
    verifyNever(() => repository.searchByText(any()));
  });

  test('Should return DataSourceError when repository fails', () async {
    when(() => repository.searchByText(any()))
        .thenAnswer((_) async => Left(DataSourceError()));

    final result = await usecase(text);
    expect(result, Left(DataSourceError()));
    verify(() => repository.searchByText(text)).called(1);
  });
}
