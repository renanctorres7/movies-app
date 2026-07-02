import 'package:movies/app/features/search/domain/entities/entities.dart';

class MovieDetailsArgs {
  final SearchResultsEntity movie;
  final List<String> genreNames;
  final String imageUrl;

  const MovieDetailsArgs({
    required this.movie,
    required this.genreNames,
    required this.imageUrl,
  });
}
