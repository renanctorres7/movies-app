import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/features/infra/datasources/search_genres_datasource.dart';
import 'package:movies/app/features/infra/models/search_genres_model.dart';
import 'package:movies/app/features/infra/repositories/search_genres_repository_impl.dart';

class SearchGenresDatasourceMock extends Mock
    implements SearchGenresDatasource {}

void main() {
  final datasource = SearchGenresDatasourceMock();
  final repository = SearchGenresRepositoryImpl(datasource);
  List<SearchGenresModel> list = [];
  test('Should return a Search Genre Model list', () async {
    when(() => datasource.searchGenres()).thenAnswer((_) async => list);
    final result = await repository.getGenresList();
    expect(result, Right(list));
  });
}
