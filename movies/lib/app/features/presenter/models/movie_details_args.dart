import 'package:movies/app/features/domain/entities/search_results.dart';

class MovieDetailsArgs {
  final SearchResults movie;
  final List<String> genreNames;

  const MovieDetailsArgs({
    required this.movie,
    required this.genreNames,
  });
}
