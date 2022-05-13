import 'package:get/get.dart';
import 'package:movies/app/features/presenter/stores/search_store.dart';

class SearchBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SearchStore());
  }
}
