import 'package:dartz/dartz.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';
import 'package:movies/app/features/domain/repositories/search_genres_repository.dart';

import '../errors/errors.dart';

abstract class SearchGenresUsecase {
  Future<Either<Failure, List<SearchGenres>>> call();
}

class SearchGenresUsecaseImpl implements SearchGenresUsecase {
  final SearchGenresRepository repository;

  SearchGenresUsecaseImpl(this.repository);
  @override
  Future<Either<Failure, List<SearchGenres>>> call() async {
    return await repository.getGenresList();
  }
}
