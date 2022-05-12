import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/keys/movie_database_api_key.dart';
import 'package:movies/app/features/external/endpoints/movie_database_endpoints.dart';
import 'package:movies/app/features/external/movie_database_datasource.dart';
import 'package:movies/app/features/infra/models/search_results_model.dart';

import '../../../utils/json_response.dart';

class ClientMock extends Mock implements Client {}

void main() {
  final client = ClientMock();
  final datasource = MovieDatabaseDatasource(client);
  String text = "vingadores";

  test('Should return a Search Result Model ', () async {
    when(() => client.get(Uri.parse(MovieDatabaseEndpoints.getUrlMovieSearch(
            MovieDatabaseApiKeys.apiKey, text))))
        .thenAnswer((invocation) async => Response(jsonResponse, 200));
    final result = await datasource.searchText(text);
    expect(result, isA<List<SearchResultsModel>>());
  });
}
