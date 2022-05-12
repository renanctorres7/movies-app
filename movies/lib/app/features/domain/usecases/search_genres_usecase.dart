import 'package:dartz/dartz.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';

import '../errors/errors.dart';

abstract class SearchGenresUsecase {
  Future<Either<Failure, List<SearchGenres>>> call();
}

class SearchGenresUsecaseImpl implements SearchGenresUsecase {
  @override
  Future<Either<Failure, List<SearchGenres>>> call() {
    throw UnimplementedError();
  }
}
