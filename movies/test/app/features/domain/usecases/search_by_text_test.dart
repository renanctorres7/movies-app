import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/features/domain/entities/search_results.dart';
import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/domain/repositories/search_results_repository.dart';
import 'package:movies/app/features/domain/usecases/search_by_text.dart';

class SearchResultsRepositoryMock extends Mock
    implements SearchResultsRepository {}

void main() {
  final repository = SearchResultsRepositoryMock();
  final usecase = SearchByTextImpl(repository);
  String text = 'teste';
  List<SearchResults> list = [];
  test('Should return a list with results', () async {
    when(() => repository.getListResults(text))
        .thenAnswer((_) async => Right(list));

    final result = await usecase(text);
    expect(result | [], isA<List<SearchResults>>());
  });

  test('Should return a list with results', () async {
    when(() => repository.getListResults(text))
        .thenAnswer((_) async => Right(list));

    final result = await usecase(text);
    expect(result | [], isA<List<SearchResults>>());
  });

  test('Should return Invalid Search Text when a text is invalid', () async {
    final result = usecase(null);
    expect(result, Left(Failure()));
  });
}
