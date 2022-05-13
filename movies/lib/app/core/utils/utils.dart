import 'package:movies/app/features/external/movie_database/endpoints/movie_database_endpoints.dart';

class Utils {
  static String trimUrlImage(String imageUrl) {
    return MovieDatabaseEndpoints.baseImageUrl + imageUrl.replaceAll("/", "");
  }
}
