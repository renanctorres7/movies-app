import 'package:dartz/dartz.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/search/domain/entities/entities.dart';
import 'package:movies/app/features/search/domain/repository/repository.dart';
import 'package:movies/app/features/search/infra/datasources/datasources.dart';

class GetPopularMoviesRepositoryImpl implements GetPopularMoviesRepository {
  final GetPopularMoviesDatasource datasource;

  GetPopularMoviesRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureError, List<SearchResultsEntity>>>
      getPopularMovies() async {
    try {
      final result = await datasource.getPopularMovies();
      return result != null ? Right(result) : Left(NullError());
    } catch (_) {
      return Left(DataSourceError());
    }
  }
}
