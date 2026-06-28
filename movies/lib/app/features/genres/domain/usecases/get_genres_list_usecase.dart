import 'package:dartz/dartz.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/genres/domain/entities/entities.dart';
import 'package:movies/app/features/genres/domain/repository/repository.dart';

abstract class GetGenresListUsecase {
  Future<Either<FailureError, List<GenresEntity>>> call();
}

class GetGenresListUsecaseImpl implements GetGenresListUsecase {
  final GetGenresListRepository repository;

  GetGenresListUsecaseImpl(this.repository);

  @override
  Future<Either<FailureError, List<GenresEntity>>> call() async {
    return repository.getGenresList();
  }
}
