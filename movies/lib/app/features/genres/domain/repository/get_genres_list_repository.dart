import 'package:dartz/dartz.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/genres/domain/entities/entities.dart';

abstract class GetGenresListRepository {
  Future<Either<FailureError, List<GenresEntity>>> getGenresList();
}
