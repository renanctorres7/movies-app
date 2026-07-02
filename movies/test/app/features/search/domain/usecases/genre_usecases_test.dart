import 'package:flutter_test/flutter_test.dart';
import 'package:movies/app/features/genres/infra/models/models.dart';
import 'package:movies/app/features/search/domain/usecases/usecases.dart';
import 'package:movies/app/features/search/infra/models/models.dart';

void main() {
  final resolveGenreNames = ResolveGenreNamesUsecase();
  final filterByGenre = FilterSearchResultsByGenreUsecase(resolveGenreNames);
  final collectUniqueGenreNames =
      CollectUniqueGenreNamesUsecase(resolveGenreNames);

  final genres = [
    const GenresModel(id: 28, name: 'Ação'),
    const GenresModel(id: 12, name: 'Aventura'),
  ];

  final results = [
    const SearchResultsModel(title: 'Filme 1', genreIds: [28, 12]),
    const SearchResultsModel(title: 'Filme 2', genreIds: [12]),
  ];

  test('ResolveGenreNamesUsecase maps ids to names', () {
    final names = resolveGenreNames(genreIds: [28, 12], genres: genres);

    expect(names, ['Ação', 'Aventura']);
  });

  test('FilterSearchResultsByGenreUsecase filters by genre name', () {
    final filtered = filterByGenre(
      results: results,
      genreName: 'Ação',
      genres: genres,
    );

    expect(filtered.length, 1);
    expect(filtered.first.title, 'Filme 1');
  });

  test('CollectUniqueGenreNamesUsecase returns unique genre names', () {
    final names = collectUniqueGenreNames(results: results, genres: genres);

    expect(names, containsAll(['Ação', 'Aventura']));
    expect(names.length, 2);
  });
}
