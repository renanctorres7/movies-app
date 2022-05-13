import 'package:get/get.dart';
import '../../domain/usecases/search_genres_usecase.dart';
import '../stores/genres_store.dart';

class GenresBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GenresStore(Get.find<SearchGenresUsecaseImpl>()));
  }
}
