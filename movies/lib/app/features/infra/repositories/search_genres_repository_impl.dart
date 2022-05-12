import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/app/features/domain/repositories/search_genres_repository.dart';

class SearchGenresRepositoryImpl implements SearchGenresRepository {
  @override
  Future<Either<Failure, List<SearchGenres>>> getGenresList() {
    throw UnimplementedError();
  }
}
