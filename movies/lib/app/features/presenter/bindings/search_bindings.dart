import 'package:get/get.dart';
import 'package:movies/app/features/presenter/stores/search_store.dart';

import '../../domain/usecases/search_by_text.dart';

class SearchBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchStore(Get.find<SearchByTextImpl>()));
  }
}
