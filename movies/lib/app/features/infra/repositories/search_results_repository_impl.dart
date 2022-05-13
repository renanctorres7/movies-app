import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/domain/entities/search_results.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/app/features/domain/repositories/search_results_repository.dart';
import 'package:movies/app/features/infra/datasources/search_results_datasource.dart';

class SearchResultsRepositoryImpl implements SearchResultsRepository {
  final SearchResultsDatasource datasource;

  SearchResultsRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, List<SearchResults>>> getListResults(
      String text) async {
    try {
      final list = await datasource.searchText(text);
      return list == null ? Left(NullDatasource()) : Right(list);
    } catch (e) {
      
      return Left(DatasourceFailure());
    }
  }
}
