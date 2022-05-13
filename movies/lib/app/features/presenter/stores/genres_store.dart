import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:movies/app/features/domain/usecases/search_genres_usecase.dart';

import '../../domain/entities/search_genres.dart';
import '../../domain/errors/errors.dart';

class GenresStore extends GetxController {
  final SearchGenresUsecase usecase;
  GenresStore(this.usecase);



  Future<Either<Failure, List<SearchGenres>>> getGenresList() async {
    return await usecase();
  }
}
