import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/endpoints/endpoints.dart';
import 'package:movies/app/features/search/data/datasource/datasource.dart';

import '../../../../../mocks/mocks.dart';

class ClientMock extends Mock implements Client {}

void main() {
  final client = ClientMock();
  const apiKey = 'test-api-key';
  const text = 'vingadores';

  group('TmdbSearchByTextDatasource', () {
    final datasource = TmdbSearchByTextDatasource(client, apiKey: apiKey);

    test('Should parse search results from TMDB response', () async {
      when(
        () => client.get(
          Uri.parse(TmdbEndpoints.getUrlMovieSearch(apiKey, text)),
        ),
      ).thenAnswer((_) async => Response(searchJsonResponse, 200));

      final result = await datasource.searchByText(text);

      expect(result, isNotNull);
      expect(result!.length, greaterThan(0));
      expect(result.first.title, isNotEmpty);
    });
  });

  group('TmdbGetPopularMoviesDatasource', () {
    final datasource = TmdbGetPopularMoviesDatasource(client, apiKey: apiKey);

    test('Should parse popular movies from TMDB response', () async {
      when(
        () => client.get(
          Uri.parse(TmdbEndpoints.getPopularMovies(apiKey)),
        ),
      ).thenAnswer((_) async => Response(searchJsonResponse, 200));

      final result = await datasource.getPopularMovies();

      expect(result, isNotNull);
      expect(result!.length, greaterThan(0));
      expect(result.first.title, isNotEmpty);
    });
  });
}
