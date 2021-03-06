import 'package:dartz/dartz.dart';
import 'package:movies/app/features/domain/entities/search_results.dart';
import 'package:movies/app/features/domain/repositories/search_results_repository.dart';

import '../errors/errors.dart';

abstract class SearchByText {
  Future<Either<Failure, List<SearchResults>>> call(String text);
}

class SearchByTextImpl implements SearchByText {
  final SearchResultsRepository repository;

  SearchByTextImpl(this.repository);

  @override
  Future<Either<Failure, List<SearchResults>>> call(String? text) async {
    return text != null
        ? await repository.getListResults(text)
        : Left(InvalidSearchText());
  }
}
