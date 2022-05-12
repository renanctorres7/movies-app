import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/app/features/domain/repositories/search_genres_repository.dart';
import 'package:movies/app/features/infra/datasources/search_genres_datasource.dart';

class SearchGenresRepositoryImpl implements SearchGenresRepository {
  final SearchGenresDatasource datasource;

  SearchGenresRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, List<SearchGenres>>> getGenresList() async {
    try {
      final list = await datasource.searchGenres();
      return Right(list);
    } catch (e) {
      return Left(DatasourceFailure());
    }
  }
}
