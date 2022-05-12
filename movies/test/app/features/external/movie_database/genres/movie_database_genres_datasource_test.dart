import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/keys/movie_database_api_key.dart';
import 'package:movies/app/features/external/movie_database/endpoints/movie_database_endpoints.dart';
import 'package:movies/app/features/external/movie_database/genres/movie_database_genres_datasource.dart';
import 'package:movies/app/features/infra/models/search_genres_model.dart';

import '../../../../../utils/genre_json_response.dart';

class ClientMock extends Mock implements Client {}

void main() {
  final client = ClientMock();
  final datasource = MovieDatabaseGenresDatasource(client);

  test('Should return a Search Genres Model ', () async {
    when(() => client.get(Uri.parse(MovieDatabaseEndpoints.getGenresSearch(
            MovieDatabaseApiKeys.apiKey))))
        .thenAnswer((_) async => Response(genreJsonResponse, 200));
    final result = await datasource.searchGenres();
    expect(result, isA<List<SearchGenresModel>>());
  });
}
