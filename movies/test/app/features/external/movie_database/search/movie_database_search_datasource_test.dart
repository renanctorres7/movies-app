import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/keys/movie_database_api_key.dart';
import 'package:movies/app/features/external/movie_database/endpoints/movie_database_endpoints.dart';
import 'package:movies/app/features/external/movie_database/search/movie_database_search_datasource.dart';
import 'package:movies/app/features/infra/models/search_results_model.dart';

import '../../../../../utils/search_json_response.dart';

class ClientMock extends Mock implements Client {}

void main() {
  final client = ClientMock();
  final datasource = MovieDatabaseSearchDatasource(client);
  String text = "vingadores";

  test('Should return a Search Result Model ', () async {
    when(() => client.get(Uri.parse(MovieDatabaseEndpoints.getUrlMovieSearch(
            MovieDatabaseApiKeys.apiKey, text))))
        .thenAnswer((_) async => Response(searchJsonResponse, 200));
    final result = await datasource.searchText(text);
    expect(result, isA<List<SearchResultsModel>>());
  });
}
