import 'package:dartz/dartz.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';

import '../errors/errors.dart';

abstract class SearchGenresById {
  Future<Either<Failure, List<SearchGenres>>> call(int id);
}

class SearchGenresByIdImpl implements SearchGenresById {
  @override
  Future<Either<Failure, List<SearchGenres>>> call(int id) {
    throw UnimplementedError();
  }
}
