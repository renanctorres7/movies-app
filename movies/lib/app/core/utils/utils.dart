import 'package:get/instance_manager.dart';
import 'package:movies/app/core/utils/dependency_creator.dart';
import 'package:movies/app/features/external/movie_database/endpoints/movie_database_endpoints.dart';

import '../../features/presenter/stores/search_store.dart';

class Utils {
  static String trimUrlImage(String imageUrl) {
    if (imageUrl.isNotEmpty) {
      return MovieDatabaseEndpoints.baseImageUrl + imageUrl.replaceAll("/", "");
    } else {
      return '';
    }
  }
}
