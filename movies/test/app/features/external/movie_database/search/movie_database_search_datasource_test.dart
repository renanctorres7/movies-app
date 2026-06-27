import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/features/external/movie_database/endpoints/movie_database_endpoints.dart';
import 'package:movies/app/features/external/movie_database/search/movie_database_search_datasource.dart';

import '../../../../../utils/search_json_response.dart';

class ClientMock extends Mock implements Client {}

void main() {
  final client = ClientMock();
  const apiKey = 'test-api-key';
  final datasource = MovieDatabaseSearchDatasource(client, apiKey: apiKey);
  const text = 'vingadores';

  test('Should parse search results from TMDB response', () async {
    when(
      () => client.get(
        Uri.parse(MovieDatabaseEndpoints.getUrlMovieSearch(apiKey, text)),
      ),
    ).thenAnswer((_) async => Response(searchJsonResponse, 200));

    final result = await datasource.searchText(text);

    expect(result, isNotNull);
    expect(result!.length, greaterThan(0));
    expect(result.first.title, isNotEmpty);
  });
}
