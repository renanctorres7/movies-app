import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/utils/dependency_creator.dart';
import 'package:movies/app/features/domain/entities/search_results.dart';
import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/domain/usecases/search_by_text.dart';
import 'package:movies/app/features/presenter/stores/search_store.dart';

class SearchByTextMock extends Mock implements SearchByText {}

void main() {
  SearchStore? store;
  SearchByText? usecase = SearchByTextMock();
  List<SearchResults> testList = [];
  String text = "vingadores";

  setUp(() {
    DependencyCreator.init();
    store = SearchStore(usecase: usecase, genresUsecase: s1());
  });

  test('Should return a Search Results from the usecase', () async {
    when(() => usecase.call(text)).thenAnswer((_) async => Right(testList));

    final result = await store?.getListResults(text);

    expect(result, Right(testList));
    verify(() => usecase(text)).called(1);
  });

  test('Should return a Server Failure from the usecase when there is an error',
      () async {
    when(() => usecase.call(any()))
        .thenAnswer((_) async => Left(ServerFailure()));

    final result = await store?.getListResults(text);

    expect(result, Left(ServerFailure()));
    verify(() => usecase(text)).called(1);
  });
}
