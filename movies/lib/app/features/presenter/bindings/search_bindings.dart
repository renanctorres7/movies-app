import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/app/features/presenter/stores/search_store.dart';

final s1 = GetIt.instance;

class SearchBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SearchStore(usecase: s1(), genresUsecase: s1()));
  }
}
