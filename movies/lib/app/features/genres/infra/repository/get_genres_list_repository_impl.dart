import 'package:dartz/dartz.dart';
import 'package:movies/app/core/errors/api_exception.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/genres/domain/entities/entities.dart';
import 'package:movies/app/features/genres/domain/repository/repository.dart';
import 'package:movies/app/features/genres/infra/datasources/datasources.dart';

class GetGenresListRepositoryImpl implements GetGenresListRepository {
  final GetGenresListDatasource datasource;

  GetGenresListRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureError, List<GenresEntity>>> getGenresList() async {
    try {
      final result = await datasource.getGenresList();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiError(statusCode: e.statusCode, message: e.message));
    } catch (_) {
      return Left(DataSourceError());
    }
  }
}
