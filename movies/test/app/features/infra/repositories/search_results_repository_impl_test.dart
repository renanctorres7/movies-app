import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
      posterPath: "/pMdTc3kYCD1869UX6cdYUT8Xe49.jpg",
      adult: false,
      overview:
          "Feature-length documentary about the rise of Marvel Studios and their films leading up to, and including, The Avengers.",
      releaseDate: "2012-09-25",
      genreIds: [99],
      id: 161097,
      originalTitle: "Marvel Studios: Building a Cinematic Universe",
      originalLanguage: 'en',
      title: "Marvel Studios: Building a Cinematic Universe",
      backdropPath: "/yeKT2gNFxHGbTT3Htj5PE9IerGJ.jpg",
      popularity: 1.136598,
      voteCount: 4,
      video: false,
      voteAverage: 3.88,
    )
  ];
  test('Should return a Search Result Model list', () async {
    when(() => datasource.searchText(text)).thenAnswer((_) async => testList);

    final result = await repository.getListResults(text);
    expect(result, Right(testList));
  });
}
