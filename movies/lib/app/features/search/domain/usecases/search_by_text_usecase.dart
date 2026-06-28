import 'package:dartz/dartz.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/search/domain/entities/entities.dart';
import 'package:movies/app/features/search/domain/repository/repository.dart';

abstract class SearchByTextUsecase {
  Future<Either<FailureError, List<SearchResultsEntity>>> call(String text);
}

class SearchByTextUsecaseImpl implements SearchByTextUsecase {
  final SearchByTextRepository repository;

  SearchByTextUsecaseImpl(this.repository);

  @override
  Future<Either<FailureError, List<SearchResultsEntity>>> call(
    String text,
  ) async {
    if (text.isEmpty) {
      return Left(InvalidSearchText());
    }

    return repository.searchByText(text);
  }
}
