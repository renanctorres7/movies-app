import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';
import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/domain/repositories/search_genres_repository.dart';
import 'package:movies/app/features/domain/usecases/search_genres_usecase.dart';

class SearchGenresRepositoryMock extends Mock
    implements SearchGenresRepository {}

void main() {
  final repository = SearchGenresRepositoryMock();
  final usecase = SearchGenresUsecaseImpl(repository);

  final list = <SearchGenres>[];

  test('Should receive a Search Genres list', () async {
    when(() => repository.getGenresList()).thenAnswer((_) async => Right(list));
    final result = await usecase.call();

    expect(result, Right(list));
  });

  test('Should return UnexpectedFailure when repository fails', () async {
    when(() => repository.getGenresList())
        .thenAnswer((_) async => Left(UnexpectedFailure()));
    final result = await usecase.call();

    expect(result, Left(UnexpectedFailure()));
  });
}
