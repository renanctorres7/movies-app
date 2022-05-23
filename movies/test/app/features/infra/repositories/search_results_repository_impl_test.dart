import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/infra/datasources/search_results_datasource.dart';
import 'package:movies/app/features/infra/models/search_results_model.dart';
import 'package:movies/app/features/infra/repositories/search_results_repository_impl.dart';

class SearchResultsDatasourceMock extends Mock
    implements SearchResultsDatasource {}

void main() {
  final datasource = SearchResultsDatasourceMock();
  final repository = SearchResultsRepositoryImpl(datasource);
  String text = 'teste';

  List<SearchResultsModel> testList = [
    SearchResultsModel(
      overview:
          "Feature-length documentary about the rise of Marvel Studios and their films leading up to, and including, The Avengers.",
      releaseDate: "2012-09-25",
      genreIds: [99],
      originalTitle: "Marvel Studios: Building a Cinematic Universe",
      title: "Marvel Studios: Building a Cinematic Universe",
      backdropPath: "/yeKT2gNFxHGbTT3Htj5PE9IerGJ.jpg",
      voteAverage: 3.88,
    )
  ];
  test('Should return a Search Result Model list', () async {
    when(() => datasource.searchText(text)).thenAnswer((_) async => testList);

    final result = await repository.getListResults(text);
    expect(result, Right(testList));
  });

  test('Should return a Null Datasource error if datasource returns null ',
      () async {
    when(() => datasource.searchText(text)).thenAnswer((_) async => null);

    final result = await repository.getListResults(text);
    expect(result, Left(NullDatasource()));
  });

  test('Should return a Datasource Failure if datasource catchs error ',
      () async {
    when(() => datasource.searchText(text)).thenThrow(DatasourceFailure());

    final result = await repository.getListResults(text);
    expect(result, Left(DatasourceFailure()));
  });
}
