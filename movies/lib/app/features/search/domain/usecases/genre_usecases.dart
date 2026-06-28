import 'package:movies/app/features/genres/domain/entities/entities.dart';
import 'package:movies/app/features/search/domain/entities/entities.dart';

class ResolveGenreNamesUsecase {
  List<String> call({
    required List<int> genreIds,
    required List<GenresEntity> genres,
  }) {
    if (genreIds.isEmpty || genres.isEmpty) {
      return [];
    }

    return genreIds
        .map((id) {
          final match = genres.where((genre) => genre.id == id);
          return match.isEmpty ? '' : match.first.name;
        })
        .where((name) => name.isNotEmpty)
        .toList();
  }
}

class FilterSearchResultsByGenreUsecase {
  final ResolveGenreNamesUsecase resolveGenreNames;

  FilterSearchResultsByGenreUsecase(this.resolveGenreNames);

  List<SearchResultsEntity> call({
    required List<SearchResultsEntity> results,
    required String genreName,
    required List<GenresEntity> genres,
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
    required List<SearchResultsEntity> results,
    required List<GenresEntity> genres,
  }) {
    final ids = <int>{};

    for (final result in results) {
      ids.addAll(result.genreIds ?? []);
    }

    return resolveGenreNames(genreIds: ids.toList(), genres: genres);
  }
}
