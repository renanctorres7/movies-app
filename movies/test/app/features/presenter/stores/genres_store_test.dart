import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';
import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/domain/usecases/search_genres_usecase.dart';
import 'package:movies/app/features/presenter/stores/genres_store.dart';

class SearchGenresUsecaseMock extends Mock implements SearchGenresUsecase {}

void main() {
  late GenresStore store;
  late SearchGenresUsecase usecase;
  List<SearchGenres> testList = [];
  String text = "vingadores";

  setUp(() {
    usecase = SearchGenresUsecaseMock();
    store = Get.put(GenresStore(usecase));
  });

  test('Should return a Search Genres results from the usecase', () async {
    when(() => usecase.call()).thenAnswer((_) async => Right(testList));

    final result = await store.getGenresList();

    expect(result, Right(testList));
    verify(() => usecase()).called(1);
  });

  test('Should return a Server Failure from the usecase when there is an error',
      () async {
    when(() => usecase.call()).thenAnswer((_) async => Left(ServerFailure()));

    final result = await store.getGenresList();

    expect(result, Left(ServerFailure()));
    verify(() => usecase()).called(1);
  });
}
