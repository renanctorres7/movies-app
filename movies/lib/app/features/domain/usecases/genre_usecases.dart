import 'package:movies/app/features/domain/entities/search_genres.dart';
import 'package:movies/app/features/domain/entities/search_results.dart';

class ResolveGenreNamesUsecase {
  List<String> call({
    required List<int> genreIds,
    required List<SearchGenres> genres,
  }) {
    if (genreIds.isEmpty || genres.isEmpty) {
      return [];
    }

    return genreIds
        .map((id) => genres.firstWhere(
              (genre) => genre.id == id,
              orElse: () => SearchGenres(id: id, name: ''),
            ))
        .map((genre) => genre.name)
        .where((name) => name.isNotEmpty)
        .toList();
  }
}

class FilterSearchResultsByGenreUsecase {
  final ResolveGenreNamesUsecase resolveGenreNames;

  FilterSearchResultsByGenreUsecase(this.resolveGenreNames);

  List<SearchResults> call({
    required List<SearchResults> results,
    required String genreName,
    required List<SearchGenres> genres,
  }) {
    return results.where((result) {
      final names = resolveGenreNames(
        genreIds: result.genreIds ?? [],
        genres: genres,
      );
      return names.contains(genreName);
    }).toList();
  }
}

class CollectUniqueGenreNamesUsecase {
  final ResolveGenreNamesUsecase resolveGenreNames;

  CollectUniqueGenreNamesUsecase(this.resolveGenreNames);

  List<String> call({
    required List<SearchResults> results,
    required List<SearchGenres> genres,
  }) {
    final ids = <int>{};

    for (final result in results) {
      ids.addAll(result.genreIds ?? []);
    }

    return resolveGenreNames(genreIds: ids.toList(), genres: genres);
  }
}
