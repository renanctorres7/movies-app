import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/domain/entities/search_results.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/app/features/domain/repositories/search_results_repository.dart';

class SearchResultsRepositoryImpl implements SearchResultsRepository {
  @override
  Future<Either<Failure, List<SearchResults>>> getListResults(String text) {
    throw UnimplementedError();
  }
}
