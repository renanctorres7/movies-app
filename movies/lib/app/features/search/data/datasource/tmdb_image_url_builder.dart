import 'package:movies/app/core/core.dart';
import 'package:movies/app/features/search/infra/contracts/image_url_builder.dart';

class TmdbImageUrlBuilder implements ImageUrlBuilder {
  @override
  String buildPosterUrl(String path) {
    if (path.isEmpty) {
      return '';
    }

    return '${TmdbEndpoints.baseImageUrl}${path.replaceAll('/', '')}';
  }
}
