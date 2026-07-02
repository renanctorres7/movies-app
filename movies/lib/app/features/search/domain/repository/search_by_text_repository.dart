import 'package:dartz/dartz.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/search/domain/entities/entities.dart';

abstract class SearchByTextRepository {
  Future<Either<FailureError, List<SearchResultsEntity>>> searchByText(
    String text,
  );
}
