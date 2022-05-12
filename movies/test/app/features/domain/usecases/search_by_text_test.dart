import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/features/domain/repositories/search_results_repository.dart';
import 'package:movies/app/features/domain/usecases/search_by_text.dart';

class SearchResultsRepositoryMock extends Mock
    implements SearchResultsRepository {}

void main() {
  final repository = SearchResultsRepositoryMock();
  final usecase = SearchByTextImpl();
  test('Should return a list with results', () {});
}
