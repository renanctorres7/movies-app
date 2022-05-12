import 'package:dartz/dartz.dart';
import 'package:movies/app/features/domain/entities/search_results.dart';
import 'package:movies/app/features/domain/errors/errors.dart';

abstract class SearchResultsRepository {
  Future<Either<Failure, List<SearchResults>>> getListResults(String text);
}
