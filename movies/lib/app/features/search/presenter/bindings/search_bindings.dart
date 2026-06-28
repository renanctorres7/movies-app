import 'package:get/get.dart';
import 'package:movies/app/core/utils/dependency_creator.dart';
import 'package:movies/app/features/search/presenter/stores/search_store.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SearchStore(
        searchByTextUsecase: getIt(),
        getPopularMoviesUsecase: getIt(),
        getGenresListUsecase: getIt(),
        resolveGenreNamesUsecase: getIt(),
        filterByGenreUsecase: getIt(),
        collectUniqueGenreNamesUsecase: getIt(),
        imageUrlBuilder: getIt(),
      ),
    );
  }
}
