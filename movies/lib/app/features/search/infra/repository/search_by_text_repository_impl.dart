import 'package:dartz/dartz.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/search/domain/entities/entities.dart';
import 'package:movies/app/features/search/domain/repository/repository.dart';
import 'package:movies/app/features/search/infra/datasources/datasources.dart';

class SearchByTextRepositoryImpl implements SearchByTextRepository {
  final SearchByTextDatasource datasource;

  SearchByTextRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureError, List<SearchResultsEntity>>> searchByText(
    String text,
  ) async {
    try {
      final result = await datasource.searchByText(text);
      return result != null ? Right(result) : Left(NullError());
    } catch (_) {
      return Left(DataSourceError());
    }
  }
}
