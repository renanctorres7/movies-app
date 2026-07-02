import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/endpoints/endpoints.dart';
import 'package:movies/app/features/genres/data/datasource/datasource.dart';

import '../../../../../mocks/mocks.dart';

class ClientMock extends Mock implements Client {}

void main() {
  final client = ClientMock();
  const apiKey = 'test-api-key';
  final datasource = TmdbGetGenresDatasource(client, apiKey: apiKey);

  test('Should parse genres from TMDB response', () async {
    when(
      () => client.get(
        Uri.parse(TmdbEndpoints.getGenresSearch(apiKey)),
      ),
    ).thenAnswer((_) async => Response(genreJsonResponse, 200));

    final result = await datasource.getGenresList();

    expect(result, isNotEmpty);
    expect(result.first.id, greaterThan(0));
    expect(result.first.name, isNotEmpty);
  });
}
