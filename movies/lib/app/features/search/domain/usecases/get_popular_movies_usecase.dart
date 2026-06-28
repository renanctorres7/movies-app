import 'package:dartz/dartz.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/search/domain/entities/entities.dart';
import 'package:movies/app/features/search/domain/repository/repository.dart';

abstract class GetPopularMoviesUsecase {
  Future<Either<FailureError, List<SearchResultsEntity>>> call();
}

class GetPopularMoviesUsecaseImpl implements GetPopularMoviesUsecase {
  final GetPopularMoviesRepository repository;

  GetPopularMoviesUsecaseImpl(this.repository);

  @override
  Future<Either<FailureError, List<SearchResultsEntity>>> call() {
    return repository.getPopularMovies();
  }
}
