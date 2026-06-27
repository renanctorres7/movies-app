import 'package:movies/app/features/external/movie_database/endpoints/movie_database_endpoints.dart';
import 'package:movies/app/features/infra/contracts/image_url_builder.dart';

class TmdbImageUrlBuilder implements ImageUrlBuilder {
  @override
  String buildPosterUrl(String path) {
    if (path.isEmpty) {
      return '';
    }

    return '${MovieDatabaseEndpoints.baseImageUrl}${path.replaceAll('/', '')}';
  }
}
