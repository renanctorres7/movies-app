import 'package:dartz/dartz.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/search/domain/entities/entities.dart';

abstract class GetPopularMoviesRepository {
  Future<Either<FailureError, List<SearchResultsEntity>>> getPopularMovies();
}
