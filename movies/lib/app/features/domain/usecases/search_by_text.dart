import 'package:dartz/dartz.dart';
import 'package:movies/app/features/domain/entities/search_results.dart';

import '../errors/errors.dart';

abstract class SearchByText {
  Future<Either<Failure, List<SearchResults>>> call(String text);
}
