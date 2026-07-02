import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/search/domain/repository/repository.dart';
import 'package:movies/app/features/search/domain/usecases/usecases.dart';
import 'package:movies/app/features/search/infra/models/models.dart';

class GetPopularMoviesRepositoryMock extends Mock
    implements GetPopularMoviesRepository {}

void main() {
  final repository = GetPopularMoviesRepositoryMock();
  final usecase = GetPopularMoviesUsecaseImpl(repository);
  final list = <SearchResultsModel>[
    const SearchResultsModel(title: 'Popular Movie'),
  ];

  test('Should return a list with popular movies', () async {
    when(() => repository.getPopularMovies())
        .thenAnswer((_) async => Right(list));

    final result = await usecase();
    expect(result, Right(list));
    verify(() => repository.getPopularMovies()).called(1);
  });

  test('Should return DataSourceError when repository fails', () async {
    when(() => repository.getPopularMovies())
        .thenAnswer((_) async => Left(DataSourceError()));

    final result = await usecase();
    expect(result, Left(DataSourceError()));
    verify(() => repository.getPopularMovies()).called(1);
  });
}
