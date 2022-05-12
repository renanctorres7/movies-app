import 'package:flutter_triple/flutter_triple.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';
import 'package:movies/app/features/domain/usecases/search_genres_usecase.dart';

import '../../../domain/errors/errors.dart';

class GenresStore extends NotifierStore<Failure, List<SearchGenres>> {
  final SearchGenresUsecase usecase;
  GenresStore(this.usecase) : super([]);

  getGenresList() async {
    executeEither(() async =>
        usecase() as Future<EitherAdapter<Failure, List<SearchGenres>>>);
  }
}
