import 'package:get/get.dart';
import 'package:movies/app/core/utils/dependency_creator.dart';
import 'package:movies/app/features/presenter/stores/search_store.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SearchStore(
        usecase: getIt(),
        genresUsecase: getIt(),
        resolveGenreNamesUsecase: getIt(),
        filterByGenreUsecase: getIt(),
        collectUniqueGenreNamesUsecase: getIt(),
      ),
    );
  }
}
