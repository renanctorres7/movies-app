import 'package:dartz/dartz.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';
import 'package:movies/app/features/domain/errors/errors.dart';

abstract class SearchGenresRepository {
  Future<Either<Failure, List<SearchGenres>>> getGenresList();
}
