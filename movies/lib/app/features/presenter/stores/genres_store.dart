import 'package:get/get.dart';
import 'package:movies/app/features/domain/usecases/search_genres_usecase.dart';

class GenresStore extends GetxController {
  late SearchGenresUsecase usecase;

  getGenresList() async {
    await usecase();
  }
}
