import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movies/app/features/domain/entities/search_results.dart';
import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/domain/usecases/search_by_text.dart';
import 'package:movies/app/features/domain/usecases/search_genres_usecase.dart';
import 'package:movies/app/features/presenter/stores/search_store.dart';

class SearchByTextMock extends Mock implements SearchByText {}

class SearchGenresUsecaseMock extends Mock implements SearchGenresUsecase {}

void main() {
  SearchStore? store;
  SearchByText? usecase = SearchByTextMock();
  SearchGenresUsecase? genresUsecase = SearchGenresUsecaseMock();

  List<SearchResults> testList = [];
  String text = "vingadores";

  setUp(() {
    store = SearchStore(usecase: usecase, genresUsecase: genresUsecase);
  });

  test('Should return a Search Results from the usecase', () async {
    when(() => usecase.call(text)).thenAnswer((_) async => Right(testList));

    final result = await store?.getListResults(text);

    expect(result, Right(testList));
    verify(() => usecase(text)).called(1);
  });

  test(
      'Should return a Invalid Search Text from the usecase when there is an error',
      () async {
    when(() => usecase.call(any()))
        .thenAnswer((_) async => Left(InvalidSearchText()));

    final result = await store?.getListResults(text);

    expect(result, Left(InvalidSearchText()));
    verify(() => usecase(text)).called(1);
  });
}
